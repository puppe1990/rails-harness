#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

assert_eq() {
  local actual="$1"
  local expected="$2"
  local message="$3"
  if [ "$actual" != "$expected" ]; then
    echo "ASSERTION FAILED: $message"
    echo "Expected: $expected"
    echo "Actual:   $actual"
    exit 1
  fi
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local message="$3"
  if [[ "$haystack" != *"$needle"* ]]; then
    echo "ASSERTION FAILED: $message"
    echo "Needle: $needle"
    exit 1
  fi
}

json_get() {
  local json="$1"
  local query="$2"
  printf '%s' "$json" | jq -r "$query"
}

echo "==> audit json on bundled templates"
audit_crud="$(script/audit-template-fit template --json)"
assert_eq "$(json_get "$audit_crud" '.recommended_template')" "rails-api-crud" "crud template should recommend rails-api-crud"

audit_modular="$(script/audit-template-fit template-rails-modular-monolith --json)"
assert_eq "$(json_get "$audit_modular" '.recommended_template')" "rails-modular-monolith" "modular template should recommend rails-modular-monolith"

audit_sidekiq="$(script/audit-template-fit template-rails-sidekiq-event-processing --json)"
assert_eq "$(json_get "$audit_sidekiq" '.recommended_template')" "rails-sidekiq-event-processing" "sidekiq template should recommend rails-sidekiq-event-processing"

echo "==> bootstrap + doctor on temp app"
tmpdir="$(mktemp -d /tmp/rails-harness-test.XXXXXX)"
mkdir -p "$tmpdir/app"
touch "$tmpdir/app/Gemfile"

script/bootstrap-template rails-api-crud "$tmpdir/app" >/tmp/rails-harness-test-bootstrap.log
bootstrap_output="$(cat /tmp/rails-harness-test-bootstrap.log)"
assert_contains "$bootstrap_output" "Template installed." "bootstrap should report installation"

doctor_json="$(script/doctor-template "$tmpdir/app" rails-api-crud --json)"
assert_eq "$(json_get "$doctor_json" '.result')" "PASS" "doctor should pass on bootstrapped CRUD app"
assert_eq "$(json_get "$doctor_json" '.template')" "rails-api-crud" "doctor should report the expected template"

echo "==> bootstrap should auto-overwrite fresh rails boilerplate"
tmpdir_boilerplate="$(mktemp -d /tmp/rails-harness-boilerplate.XXXXXX)"
mkdir -p "$tmpdir_boilerplate/app/app/controllers" "$tmpdir_boilerplate/app/app/models"
touch "$tmpdir_boilerplate/app/Gemfile"
cat > "$tmpdir_boilerplate/app/README.md" <<'EOF'
# README
EOF
cat > "$tmpdir_boilerplate/app/app/controllers/application_controller.rb" <<'EOF'
class ApplicationController < ActionController::API
end
EOF
cat > "$tmpdir_boilerplate/app/app/models/application_record.rb" <<'EOF'
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
EOF
boilerplate_output="$(script/bootstrap-template rails-api-crud "$tmpdir_boilerplate/app")"
assert_contains "$boilerplate_output" "Auto-overwriting Rails boilerplate files:" "bootstrap should auto-overwrite default rails files"

echo "==> onboard on temp app"
tmpdir_onboard="$(mktemp -d /tmp/rails-harness-onboard.XXXXXX)"
mkdir -p "$tmpdir_onboard/app"
touch "$tmpdir_onboard/app/Gemfile"

onboard_output="$(script/onboard "$tmpdir_onboard/app" rails-api-crud)"
assert_contains "$onboard_output" "Onboarding result: PASS" "onboard should finish successfully"

echo "==> ci scripts should run security checks and detect coverage hooks consistently"
tmpdir_ci="$(mktemp -d /tmp/rails-harness-ci.XXXXXX)"
mkdir -p "$tmpdir_ci/bin"

cat > "$tmpdir_ci/bin/bundle" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
echo "bundle $*" >> "${BUNDLE_LOG:?}"
exit 0
EOF
chmod +x "$tmpdir_ci/bin/bundle"

templates=(
  "rails-api-crud"
  "rails-modular-monolith"
  "rails-sidekiq-event-processing"
)

for template_name in "${templates[@]}"; do
  app_dir="$tmpdir_ci/$template_name"
  mkdir -p "$app_dir"
  touch "$app_dir/Gemfile"

  script/bootstrap-template "$template_name" "$app_dir" >/dev/null

  cat > "$app_dir/Gemfile" <<'EOF'
source "https://rubygems.org"

gem "rspec-rails"
gem "rubocop"
gem "brakeman"
gem "bundler-audit"
gem "simplecov"
EOF

  touch "$app_dir/.rubocop.yml" "$app_dir/.simplecov"

  bundle_log="$tmpdir_ci/${template_name}.bundle.log"
  : > "$bundle_log"

  ci_fast_output="$(
    cd "$app_dir" &&
      PATH="$tmpdir_ci/bin:$PATH" BUNDLE_LOG="$bundle_log" ./script/ci-fast
  )"
  assert_contains "$ci_fast_output" "==> brakeman" "ci-fast should run brakeman for $template_name"
  assert_contains "$ci_fast_output" "==> bundle-audit" "ci-fast should run bundle-audit for $template_name"
  assert_contains "$(cat "$bundle_log")" "bundle exec brakeman -q" "ci-fast should invoke brakeman via bundle exec for $template_name"
  assert_contains "$(cat "$bundle_log")" "bundle exec bundle-audit check --update" "ci-fast should invoke bundle-audit via bundle exec for $template_name"

  : > "$bundle_log"
  ci_full_output="$(
    cd "$app_dir" &&
      PATH="$tmpdir_ci/bin:$PATH" BUNDLE_LOG="$bundle_log" ./script/ci-full
  )"
  assert_contains "$ci_full_output" "==> coverage hook present" "ci-full should report SimpleCov hook for $template_name"
done

echo "All script tests passed"

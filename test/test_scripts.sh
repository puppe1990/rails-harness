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

echo "==> onboard on temp app"
tmpdir_onboard="$(mktemp -d /tmp/rails-harness-onboard.XXXXXX)"
mkdir -p "$tmpdir_onboard/app"
touch "$tmpdir_onboard/app/Gemfile"

onboard_output="$(script/onboard "$tmpdir_onboard/app" rails-api-crud)"
assert_contains "$onboard_output" "Onboarding result: PASS" "onboard should finish successfully"

echo "All script tests passed"

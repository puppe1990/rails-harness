# Harness Security And Coverage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Padronizar os templates do harness para executar `brakeman`, `bundler-audit` e detectar `SimpleCov` de forma consistente.

**Architecture:** As mudancas ficam concentradas nos scripts de CI e na documentacao dos templates. A verificacao principal fica em `test/test_scripts.sh`, que bootstrapa apps temporarios e intercepta `bundle exec` com um stub para validar a intencao dos comandos.

**Tech Stack:** Bash, templates Rails, testes de shell

---

### Task 1: Cobrir o comportamento esperado nos testes de script

**Files:**
- Modify: `test/test_scripts.sh`

- [ ] **Step 1: Escrever o teste que falha**

Adicionar um bloco que:

- bootstrapa cada template em um app temporario
- injeta `Gemfile` com `rspec-rails`, `rubocop`, `brakeman`, `bundler-audit` e `simplecov`
- usa um `bundle` stub para registrar invocacoes
- valida `==> bundle-audit` no `ci-fast`
- valida `==> coverage hook present` no `ci-full`

- [ ] **Step 2: Rodar o teste para confirmar a falha**

Run: `rtk bash test/test_scripts.sh`
Expected: FAIL em templates sem `bundle-audit` e/ou sem sinalizacao consistente de `SimpleCov`

### Task 2: Padronizar os scripts dos templates

**Files:**
- Modify: `template/script/ci-fast`
- Modify: `template/script/ci-full`
- Modify: `template-rails-modular-monolith/script/ci-fast`
- Modify: `template-rails-modular-monolith/script/ci-full`
- Modify: `template-rails-sidekiq-event-processing/script/ci-fast`
- Modify: `template-rails-sidekiq-event-processing/script/ci-full`

- [ ] **Step 1: Extrair heuristica simples de deteccao de gem**

Adicionar `has_gem()` em cada script, encapsulando a busca em `Gemfile` e `Gemfile.lock`.

- [ ] **Step 2: Executar `brakeman` e `bundle-audit` no `ci-fast`**

Padronizar os tres `ci-fast` para:

- manter `rubocop`
- executar `brakeman -q` quando presente
- executar `bundle-audit check --update` quando presente
- preservar comportamento de skip quando a gem nao existir

- [ ] **Step 3: Detectar `SimpleCov` no `ci-full`**

Padronizar os tres `ci-full` para reportar `coverage hook present` quando existir `.simplecov` ou a gem `simplecov`.

### Task 3: Atualizar a documentacao

**Files:**
- Modify: `template/README.md`
- Modify: `template-rails-modular-monolith/README.md`
- Modify: `template-rails-sidekiq-event-processing/README.md`
- Modify: `docs/rails-harness.md`
- Modify: `docs/harness-maturity.md`

- [ ] **Step 1: Atualizar dependencias e checks esperados**

Adicionar `bundler-audit` nas listas de dependencias/checks e explicitar que `SimpleCov` continua opcional, mas detectado pelos scripts.

### Task 4: Verificar o resultado

**Files:**
- Modify: `test/test_scripts.sh`
- Review: scripts e docs alterados acima

- [ ] **Step 1: Rodar a suite relevante**

Run: `rtk bash test/test_scripts.sh`
Expected: PASS

- [ ] **Step 2: Revisar diff**

Run: `rtk git diff -- test/test_scripts.sh template template-rails-modular-monolith template-rails-sidekiq-event-processing docs`
Expected: Apenas scripts, docs e testes relacionados ao harness

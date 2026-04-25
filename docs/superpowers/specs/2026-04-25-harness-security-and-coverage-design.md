# Harness Security And Coverage Design

## Objetivo

Padronizar os templates do `rails-harness` para que o loop local detecte e rode `brakeman`, `bundler-audit` e a sinalizacao de `SimpleCov` de forma consistente.

## Abordagem

A integracao permanece heuristica e defensiva. Os scripts so executam checks quando a gem ou o hook correspondente aparecem no app alvo, para manter o harness reutilizavel em projetos com stacks ligeiramente diferentes.

## Escopo

- adicionar `bundle-audit` aos `script/ci-fast` dos tres templates
- garantir deteccao consistente de `SimpleCov` nos `script/ci-full`
- alinhar a documentacao de templates e docs gerais do harness
- cobrir o comportamento com teste de shell em `test/test_scripts.sh`

## Fora de escopo

- criar arquivos `.simplecov` modelo
- editar Gemfiles reais de apps consumidores
- impor falha obrigatoria quando essas gems nao existirem

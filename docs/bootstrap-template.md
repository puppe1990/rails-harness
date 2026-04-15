# Bootstrap Template

## Objetivo

Este documento explica como instalar um dos templates do repositorio dentro de um app Rails real usando o script de bootstrap.

## Script

Use [script/bootstrap-template](/Users/matheuspuppe/Desktop/Projetos/rails-harness/script/bootstrap-template).

## Templates disponiveis

- `rails-api-crud`
- `rails-modular-monolith`
- `rails-sidekiq-event-processing`

## Uso

```bash
script/bootstrap-template <template-name> <target-dir> [--force]
```

Exemplos:

```bash
script/bootstrap-template rails-api-crud ../my-rails-app
script/bootstrap-template rails-modular-monolith ../my-rails-app
script/bootstrap-template rails-sidekiq-event-processing ../my-rails-app --force
```

## Comportamento

- copia os arquivos do template selecionado para o diretorio alvo
- preserva permissao executavel dos scripts
- recusa sobrescrever arquivos existentes, a menos que `--force` seja usado
- avisa se o diretorio alvo nao parece ser a raiz de um app Rails

## Fluxo recomendado

1. escolha o template em [template-comparison-matrix.md](/Users/matheuspuppe/Desktop/Projetos/rails-harness/docs/template-comparison-matrix.md)
2. rode `script/bootstrap-template`
3. revise `AGENTS.md` e `docs/architecture.md` no app alvo
4. adapte os exemplos de `app/` e `spec/`
5. rode os checks locais do template instalado

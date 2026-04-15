# Audit Template Fit

## Objetivo

Este documento explica como usar o auditor de topologia para sugerir qual template combina melhor com um app Rails existente.

## Script

Use [script/audit-template-fit](/Users/matheuspuppe/Desktop/Projetos/rails-harness/script/audit-template-fit).

## Uso

```bash
script/audit-template-fit <target-dir> [--json]
```

Exemplos:

```bash
script/audit-template-fit ../my-rails-app
script/audit-template-fit /path/to/rails-app
```

## O que o auditor observa

- presenca de `app/controllers`, `app/serializers` e `spec/requests`
- presenca de `app/domains` e `spec/architecture`
- presenca de `app/jobs`, `app/events`, `spec/jobs` e uso de Sidekiq
- volume basico de controllers, services e dominios

## Saida

O script imprime:

- scores por template
- template recomendado
- sinais que levaram a recomendacao
- proximo comando sugerido com `script/bootstrap-template`

Com `--json`, imprime um objeto JSON com esses mesmos campos.

## Observacao

O auditor e heuristico. Ele nao substitui leitura humana do sistema. O objetivo e acelerar o primeiro enquadramento do repositorio.

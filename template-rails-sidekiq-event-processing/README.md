# Rails Sidekiq Event Processing Harness Template

Template semi-executavel para um app Rails com processamento assincrono via jobs e eventos.

Compare com os outros templates em [../docs/template-comparison-matrix.md](../docs/template-comparison-matrix.md).

## Topologia alvo

Este template assume um backend Rails em que:

- controllers publicam trabalho assincrono ou iniciam processos
- jobs executam trabalho em background
- eventos representam fatos relevantes do dominio
- services orquestram fluxos entre persistencia, jobs e eventos

## O que este template entrega

- regras do agente para Sidekiq e processamento de eventos
- documentacao de arquitetura e boundaries
- scripts de verificacao local
- esqueleto ilustrativo com controller, service, event e job
- specs estruturais para evitar jobs gordos e IO no lugar errado

## Como usar

1. Copie `template-rails-sidekiq-event-processing/` para a raiz do seu app.
2. Ajuste `AGENTS.md` e `docs/architecture.md` para as convencoes do time.
3. Revise os exemplos em `app/` e `spec/`.
4. Rode:

```bash
chmod +x script/ci-fast script/ci-full script/check_harness script/check_architecture
script/check_harness
script/ci-fast
```

## Filosofia

Neste tipo de app, o principal risco nao e apenas CRUD ruim. E side effect escondido, job com regra demais, idempotencia fraca e falta de clareza entre comando, evento e processamento assincrono.

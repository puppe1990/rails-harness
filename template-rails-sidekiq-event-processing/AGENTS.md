# Rails Sidekiq Event Processing Agent Rules

## Objetivo

Estas regras existem para reduzir drift estrutural quando agentes alteram um app Rails com jobs e eventos.

## Regras principais

1. Controllers devem iniciar fluxos e responder rapido. Nao execute trabalho pesado no request cycle.
2. Jobs devem ser pequenos, idempotentes e orientados a uma responsabilidade clara.
3. Jobs nao devem conter toda a regra de negocio. Prefira chamar um service ou processo explicito.
4. Models nao devem publicar HTTP nem fazer orquestracao assincrona diretamente.
5. Eventos devem ter nomes de fatos de dominio, nao de implementacao tecnica.
6. Se um fluxo precisar de retries, idempotencia ou deduplicacao, isso deve estar explicito no design.
7. Request specs cobrem a borda HTTP; job specs cobrem processamento assincrono; architecture specs cobrem boundaries.
8. Nomes como `Worker`, `Processor` e `Handler` so sao aceitos se o contexto de dominio estiver no nome.
9. Mudancas em contratos de evento exigem atualizar fixtures ou contratos aprovados.
10. Sempre rode `script/check_architecture` antes de concluir mudanca estrutural.

## Fluxo minimo do agente

Antes de editar:

- ler `docs/architecture.md`
- identificar onde comeca o fluxo, onde fica a orquestracao e quem executa o trabalho assincrono
- revisar exemplos em `app/jobs`, `app/events` e `app/services`

Antes de concluir:

- rodar `script/ci-fast`
- corrigir os erros encontrados
- se houver mudanca em fluxo assincrono ou contrato de evento, rodar `script/ci-full`

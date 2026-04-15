# How To Write Migration

## Regras

- migrations devem ser pequenas e reversiveis
- se introduzir tabela de outbox, eventos ou status de processamento, documente o fluxo
- considere impacto operacional de retries e reprocessamentos ao modelar novos campos

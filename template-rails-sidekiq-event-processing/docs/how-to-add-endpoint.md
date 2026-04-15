# How To Add Endpoint

## Escopo

Este guia assume um endpoint que inicia um fluxo assincrono ou um processo com Sidekiq.

## Passos

1. Escreva primeiro a request spec.
2. Confirme que ela falha pelo motivo certo.
3. Adicione ou ajuste a rota.
4. Implemente o controller para iniciar o fluxo.
5. Coloque a orquestracao em um service.
6. Enfileire o job ou publique o evento explicitamente.
7. Cubra o job com spec propria.
8. Rode `script/ci-fast`.

## Regras

- nao esconda side effect assincrono em callback sem justificativa
- o endpoint deve deixar claro se respondeu antes ou depois do processamento
- retries e idempotencia devem ser pensados quando o fluxo exigir

# How To Add Endpoint

## Passos

1. Escreva primeiro a request spec do endpoint.
2. Confirme que ela falha pelo motivo certo.
3. Implemente o controller com delegacao minima.
4. Extraia caso de uso se houver logica real.
5. Defina serializer ou contrato de resposta.
6. Rode `script/ci-fast`.

## Regras

- nao coloque regras longas no controller
- nao exponha JSON ad hoc se o endpoint for relevante
- trate autorizacao e validacao de forma explicita
- se houver efeito colateral, deixe-o visivel no fluxo

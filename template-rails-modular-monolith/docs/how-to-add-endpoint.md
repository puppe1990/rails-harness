# How To Add Endpoint

## Escopo

Este guia assume um endpoint JSON em um monolito modular.

## Passos

1. Identifique qual dominio e dono do fluxo.
2. Escreva primeiro a request spec.
3. Confirme que a spec falha pelo motivo certo.
4. Adicione ou ajuste a rota.
5. Implemente o controller apenas como adaptador HTTP.
6. Coloque a regra no dominio correto.
7. Rode `script/ci-fast`.

## Regras

- nao use o controller para costurar varios dominios sem deixar a orquestracao clara
- se um endpoint cruza modulos, documente a justificativa
- nao coloque regra de negocio em serializer

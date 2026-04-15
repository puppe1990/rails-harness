# Architecture

## Objetivo

Este arquivo define as fronteiras minimas de um `Rails modular monolith`.

## Estrutura alvo

```text
app/
├── controllers/api/
├── domains/
│   ├── catalog/
│   └── orders/
└── models/

spec/
├── architecture/
└── contracts/
```

## Regras

- cada dominio deve concentrar seus modelos, comandos, queries e serializers
- controllers de API acessam o dominio dono do fluxo
- dependencias cross-domain devem ser raras e explicitas
- shared code deve nascer apenas quando o acoplamento recorrente for real e intencional

## Boundaries de exemplo

- `Catalog` pode conhecer somente `Catalog` e infraestrutura compartilhada
- `Orders` pode conhecer `Orders`, e pode consultar `Catalog` apenas por interface explicita do fluxo
- controllers nao devem chamar ActiveRecord query chains complexas
- models de dominio nao devem chamar HTTP diretamente

## Decisoes que exigem justificativa

- novo modulo compartilhado
- dependencia direta entre dominios
- callback com side effect cruzando modulo
- mover classe de um dominio para outro

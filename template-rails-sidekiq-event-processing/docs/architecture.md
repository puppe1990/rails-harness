# Architecture

## Objetivo

Este arquivo define as fronteiras minimas de um app Rails com `Sidekiq/event processing`.

## Estrutura alvo

```text
app/
├── controllers/api/
├── jobs/
├── events/
├── services/
└── models/

spec/
├── requests/
├── jobs/
├── architecture/
└── contracts/
```

## Regras

- controllers recebem request, validam o basico e iniciam o fluxo
- services representam a orquestracao do caso de uso
- jobs executam trabalho assincrono pequeno e repetivel
- eventos representam fatos relevantes do dominio
- models guardam estado e invariantes locais

## Boundaries

- controllers nao devem executar trabalho pesado ou loops demorados
- jobs nao devem concentrar toda a regra do caso de uso
- models nao devem falar com servicos externos
- eventos nao devem virar payloads arbitrarios sem contrato

## Decisoes que exigem justificativa

- job com muitas dependencias
- callback que enfileira job implicitamente
- event payload sem fixture aprovada
- acoplamento forte entre job e controller

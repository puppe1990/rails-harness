# Template Comparison Matrix

## Objetivo

Este documento ajuda a escolher entre os templates disponiveis no repositorio.

## Visao rapida

| Template | Melhor para | Risco principal que o harness combate | Sensores mais importantes |
| --- | --- | --- | --- |
| `template/` | APIs Rails CRUD classicas | controllers gordos, query no lugar errado, contrato JSON frouxo | request specs, checks de controller thinness, checks de IO em model |
| `template-rails-modular-monolith/` | monolitos Rails com dominios explicitos | drift entre modulos, acoplamento cross-domain, perda de ownership | specs de boundaries, checks de dependencia entre dominios, arquitetura por modulo |
| `template-rails-sidekiq-event-processing/` | apps Rails com trabalho assincrono, jobs e eventos | jobs gordos, side effects escondidos, idempotencia fraca, contratos de evento soltos | job specs, checks de boundaries em jobs, contratos de evento, request specs de fluxos assincronos |

## Quando escolher cada um

### `Rails API CRUD`

Escolha [template/README.md](/Users/matheuspuppe/Desktop/Projetos/rails-harness/template/README.md) quando:

- a maior parte do sistema e endpoint REST com persistencia simples
- a principal preocupacao e manter controllers finos e JSON estavel
- services existem, mas nao sao o centro da arquitetura

Sinais de bom encaixe:

- o dominio ainda cabe bem em `controllers`, `models` e `serializers`
- request specs cobrem a maior parte do comportamento relevante
- o risco dominante e overengineering ou bagunca estrutural basica

### `Rails Modular Monolith`

Escolha [template-rails-modular-monolith/README.md](/Users/matheuspuppe/Desktop/Projetos/rails-harness/template-rails-modular-monolith/README.md) quando:

- o sistema continua sendo um monolito, mas com dominios claros
- manter fronteiras internas e mais importante do que a camada tecnica em si
- cada modulo tem ownership e linguagem propria

Sinais de bom encaixe:

- voce ja pensa em `Catalog`, `Orders`, `Billing`, `Identity` e similares
- o principal risco e acoplamento silencioso entre dominios
- `spec/architecture` precisa ser parte central do harness

### `Rails + Sidekiq/event processing`

Escolha [template-rails-sidekiq-event-processing/README.md](/Users/matheuspuppe/Desktop/Projetos/rails-harness/template-rails-sidekiq-event-processing/README.md) quando:

- a aplicacao depende fortemente de jobs, filas ou eventos
- o request cycle so inicia o trabalho e o processamento real acontece depois
- idempotencia, retries e contratos assincronos importam

Sinais de bom encaixe:

- um endpoint responde `accepted` ou agenda processamento
- side effects assincronos sao parte central do produto
- voce precisa separar claramente controller, service, event e job

## O que cada template assume

| Aspecto | Rails API CRUD | Modular Monolith | Sidekiq/Event Processing |
| --- | --- | --- | --- |
| Centro da topologia | recurso REST | dominio/modulo | fluxo assincrono |
| Sensor principal de comportamento | request spec | request spec + architecture spec | request spec + job spec |
| Sensor principal de arquitetura | controller thinness | domain boundaries | job boundaries |
| Abstracao que merece mais controle | controller/service | modulo/domain | job/service/event |
| Contrato load-bearing tipico | JSON publico | boundary interna + API | payload de evento + API |

## Regra de escolha

Se estiver em duvida:

1. Se o sistema e principalmente CRUD HTTP, comece com `Rails API CRUD`.
2. Se o maior problema e modularidade interna, use `Rails modular monolith`.
3. Se o maior risco vem de trabalho em background e side effects assincronos, use `Rails + Sidekiq/event processing`.

## Observacao

Nada impede evolucao entre templates. Um time pode nascer no template CRUD, depois migrar para o modular monolith, e ainda ter uma area especializada com Sidekiq/event processing. O importante e o harness refletir a topologia dominante do sistema.

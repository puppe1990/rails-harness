# Harness Maturity

## Objetivo

Este documento mapeia uma progressao de maturidade de harness para um app Rails. A ideia e conectar a evolucao da arquitetura com a evolucao dos guias e sensores em volta do agente.

## Nivel 1: Basico

Perfil:

- repositorio pequeno
- pouca modularidade
- poucos fluxos
- estrutura parecida com a `v1`

Harness minimo:

- `AGENTS.md` com 10 a 15 regras claras
- `rubocop`
- `rspec` basico
- `brakeman`
- `bundler-audit`
- `docs/architecture.md`

Risco dominante:

- controllers gordos
- logica espalhada
- tests verdes mas superficiais

## Nivel 2: Separacao operacional

Perfil:

- servicos e serializers comecam a aparecer
- estrutura parecida com `v2` e `v3`

Harness recomendado:

- guias de quando usar service object
- `script/ci-fast`
- request specs padrao
- review inferential para abstrações desnecessarias
- approved fixtures para JSON relevante

Risco dominante:

- proliferacao de services sem criterio
- duplicacao semantica
- convencoes inconsistentes

## Nivel 3: Dominio mais explicito

Perfil:

- enums, value objects, params e pastas por dominio
- estrutura parecida com `v4`, `v5` e `v6`

Harness recomendado:

- checks estruturais por categoria
- docs de naming e boundaries
- scripts que detectam anti-patterns em controller e model
- contract tests para APIs

Risco dominante:

- drift arquitetural
- aumento do custo de navegacao
- multiplicacao de abstracoes sem coerencia

## Nivel 4: Dominio coeso

Perfil:

- artefatos agrupados por contexto
- estrutura parecida com `v7`

Harness recomendado:

- tests de fronteira entre contextos
- scripts de arquitetura por namespace
- guias de ownership por dominio
- sensores de acoplamento

Risco dominante:

- contexts acoplados de forma invisivel
- perda de consistencia entre dominios

## Nivel 5: Dominio semantico

Perfil:

- a arvore comunica o negocio
- estrutura parecida com `v8`

Harness recomendado:

- specs com fixtures aprovadas
- review semantico comparando spec vs implementacao
- sensores de naming e intencao
- mutation testing seletivo nos fluxos centrais

Risco dominante:

- nomes semanticos bonitos mas vazios
- testes escritos pela IA cobrindo o que foi implementado, nao o que era desejado

## Regra geral

Quanto mais liberdade estrutural e semantica o repositorio permite, mais forte o harness precisa ser.

Em especial:

- se o app e pouco tipado, compense com testes e checks estruturais
- se o dominio e complexo, compense com guias e approved fixtures
- se o time quer alta autonomia do agente, compense com sensores baratos no loop local

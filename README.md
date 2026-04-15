# Rails Harness

`rails-harness` e um repositorio de referencia para pensar e materializar um harness para coding agents em projetos Rails.

O foco aqui nao e gerar um app Rails completo, e sim reunir:

- documentacao conceitual sobre harness engineering aplicada a Rails
- uma leitura progressiva de maturidade arquitetural
- um template semi-executavel que pode ser copiado para um app Rails real

## Conteudo

### Documentacao

- [docs/rails-harness.md](./docs/rails-harness.md): define o que e um `rails harness`
- [docs/harness-maturity.md](./docs/harness-maturity.md): progressao de maturidade do harness
- [docs/architecture/README.md](./docs/architecture/README.md): evolucao arquitetural `v1 -> v8`
- [docs/template-comparison-matrix.md](./docs/template-comparison-matrix.md): quando usar cada template

### Templates

O diretorio [template](./template/README.md) contem o template especializado para `Rails API CRUD`.

O diretorio [template-rails-modular-monolith](./template-rails-modular-monolith/README.md) contem o template especializado para `Rails modular monolith`.

O diretorio [template-rails-sidekiq-event-processing](./template-rails-sidekiq-event-processing/README.md) contem o template especializado para `Rails + Sidekiq/event processing`.

Os templates trazem:

- `AGENTS.md` para guiar coding agents
- `docs/` com regras operacionais
- `script/` com checks rapidos e checks estruturais
- `spec/architecture/` com sensores de exemplo
- `spec/contracts/` e `spec/fixtures/approved/` para contratos e fixtures aprovadas

## Como usar

Se voce quer aplicar isso em um app Rails real:

1. leia [docs/rails-harness.md](./docs/rails-harness.md)
2. escolha o nivel de maturidade desejado em [docs/harness-maturity.md](./docs/harness-maturity.md)
3. compare as topologias em [docs/template-comparison-matrix.md](./docs/template-comparison-matrix.md)
4. escolha o template correspondente e copie para a raiz do app
5. adapte `AGENTS.md`, `docs/` e `script/` para as convencoes do time
6. rode os checks locais do template

## Objetivo pratico

Este repositorio existe para ajudar times a:

- reduzir a liberdade estrutural do agente
- acelerar autocorrecao antes da revisao humana
- explicitar convencoes arquiteturais de Rails
- criar sensores simples para drift estrutural

## Estado do projeto

O template atual e semi-executavel:

- os scripts ja rodam
- a estrutura minima ja pode ser validada
- os checks se adaptam defensivamente quando algumas dependencias ainda nao existem

Ele foi desenhado para servir como ponto de partida, nao como framework fechado.

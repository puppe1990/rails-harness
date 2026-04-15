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
- [docs/bootstrap-template.md](./docs/bootstrap-template.md): como instalar um template em um app Rails real
- [docs/audit-template-fit.md](./docs/audit-template-fit.md): como auditar um app Rails e sugerir o template
- [docs/doctor-template.md](./docs/doctor-template.md): como validar se um app bootstrapado continua coerente com o harness
- [CONTRIBUTING.md](./CONTRIBUTING.md): como contribuir com templates e scripts

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

Ou use o bootstrap automatizado:

```bash
chmod +x script/bootstrap-template
script/bootstrap-template rails-api-crud ../my-rails-app
```

Ou rode uma sugestao automatica de encaixe:

```bash
chmod +x script/audit-template-fit
script/audit-template-fit ../my-rails-app
```

Ou valide um app bootstrapado:

```bash
chmod +x script/doctor-template
script/doctor-template ../my-rails-app
```

Ou execute tudo de uma vez:

```bash
chmod +x script/onboard
script/onboard ../my-rails-app
```

## Qualidade do proprio repositorio

O projeto tem:

- CI em [`.github/workflows/ci.yml`](./.github/workflows/ci.yml)
- pre-commit em [`.githooks/pre-commit`](./.githooks/pre-commit)

Para instalar o hook local:

```bash
chmod +x script/install-git-hooks
script/install-git-hooks
```

## Onboarding rapido

Se voce quer sair do zero para um app Rails com harness instalado, este e o fluxo minimo:

```bash
chmod +x script/audit-template-fit script/bootstrap-template script/doctor-template
script/audit-template-fit ../my-rails-app
script/bootstrap-template rails-api-crud ../my-rails-app
script/doctor-template ../my-rails-app
```

Troque `rails-api-crud` por `rails-modular-monolith` ou `rails-sidekiq-event-processing` quando o auditor ou a sua leitura da topologia apontarem outro encaixe.

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

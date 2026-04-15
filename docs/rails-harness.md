# Rails Harness

## Objetivo

Este documento define um `rails harness` como o conjunto de guias e sensores usados para deixar um coding agent mais confiavel ao trabalhar em uma aplicacao Rails.

O modelo segue quatro blocos:

- `feedforward inferential`: instrucoes e heuristicas para o agente
- `feedforward computational`: ferramentas deterministicas que restringem o espaco de erro
- `feedback computational`: checks automaticos e baratos
- `feedback inferential`: revisoes semanticas mais caras

## Formula pratica

Para um app Rails:

```text
Agent result quality = model capability + repository context + harness quality
```

Se o repositorio nao tem convencoes explicitas, contratos de comportamento e sensores rapidos, o agente opera com liberdade demais. Em Rails isso costuma piorar rapido porque o framework tolera muita variacao estrutural.

## Feedforward inferential

Guias em linguagem natural que dizem ao agente como trabalhar no sistema.

Exemplos:

- `AGENTS.md` com regras do time
- `docs/architecture.md`
- `docs/how-to-add-endpoint.md`
- `docs/how-to-write-migration.md`
- exemplos aprovados de tests, serializers e services

Esses guias respondem perguntas como:

- onde colocar logica de negocio
- quando usar service object
- quando evitar callbacks
- como escrever request specs
- como modelar boundaries entre contextos

## Feedforward computational

Ferramentas deterministicas que reduzem a liberdade do agente antes mesmo do feedback.

Exemplos:

- generators padronizados
- scripts de bootstrap
- templates de arquivos
- rubocop com cops customizados
- skeletons de specs e contratos

Em Rails, isso e util porque impede o agente de improvisar demais naming, layout e fluxo de criacao de classes.

## Feedback computational

Sensores baratos, confiaveis e repetiveis.

Exemplos:

- `bundle exec rubocop`
- `bundle exec brakeman`
- `bundle exec rspec`
- checks estruturais em `spec/architecture`
- scripts que detectam queries em controllers
- scripts que detectam chamadas HTTP em models

Esses checks devem rodar o mais cedo possivel, de preferencia antes do commit.

## Feedback inferential

Sensores semanticos que avaliam aquilo que linters e testes nem sempre capturam.

Exemplos:

- review agent focado em overengineering
- review agent focado em drift arquitetural
- judge agent comparando implementacao contra spec funcional

Em Rails, esse tipo de sensor e util para detectar:

- service object desnecessario
- callback escondendo side effect importante
- test suite fraca mas verde
- abstrações genericas demais
- naming que nao reflete o dominio

## Categorias de regulacao

### Maintainability harness

Regula qualidade interna e governabilidade do codigo.

Exemplos:

- controllers finos
- models sem IO externo
- services com responsabilidade clara
- convencoes para serializers, jobs e queries
- cobertura minima nos fluxos centrais

### Architecture fitness harness

Regula as caracteristicas arquiteturais que nao podem degradar.

Exemplos:

- contexts nao podem depender livremente uns dos outros
- controller nao faz query complexa
- model nao fala com API externa
- job nao implementa regra de negocio inteira

### Behaviour harness

Regula comportamento funcional observavel.

Exemplos:

- request specs
- approved fixtures
- contract tests
- mutation testing seletivo
- comparacao entre spec e implementacao

## Shift left

Um harness bom desloca qualidade para a esquerda:

1. o agente recebe guias claros
2. gera codigo
3. roda sensores rapidos
4. se autocorrige
5. so depois chega ao humano

O objetivo nao e eliminar revisao humana, e reduzir o volume de erro banal e estrutural que chega nela.

## Harnessability em Rails

Um codebase Rails fica mais harnessable quando:

- os contextos sao explicitos
- as convencoes estao escritas
- os tests sao rapidos
- request specs cobrem os fluxos importantes
- side effects estao visiveis
- a linguagem do dominio aparece nos nomes

Fica menos harnessable quando:

- tudo mora em `app/models` e `app/controllers`
- callbacks escondem comportamento
- concerns viram heranca informal
- os tests sao lentos ou frageis
- a arquitetura real diverge da documentada

## Os templates deste repositorio

Os diretorios [template](/Users/matheuspuppe/Desktop/Projetos/rails-harness/template/README.md) e [template-rails-modular-monolith](/Users/matheuspuppe/Desktop/Projetos/rails-harness/template-rails-modular-monolith/README.md) materializam esse modelo em estruturas semi-executaveis para topologias diferentes de apps Rails reais.

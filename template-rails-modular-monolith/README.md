# Rails Modular Monolith Harness Template

Template semi-executavel para um `Rails modular monolith`.

Compare com os outros templates em [../docs/template-comparison-matrix.md](../docs/template-comparison-matrix.md).

## Topologia alvo

Este template assume um monolito Rails organizado por dominios explicitos, com fronteiras internas que precisam ser preservadas.

Exemplo de topologia:

- `app/domains/catalog`
- `app/domains/orders`
- `app/controllers/api`
- `spec/architecture` para sensores de drift

## O que este template entrega

- regras do agente para trabalhar por modulo
- documentacao de arquitetura e boundaries
- scripts de verificacao local
- exemplos de codigo por dominio
- specs estruturais para drift arquitetural

## Como usar

1. Copie `template-rails-modular-monolith/` para a raiz do seu app.
2. Ajuste os nomes dos dominios e boundaries em `docs/architecture.md`.
3. Revise `AGENTS.md` para refletir as regras do time.
4. Rode:

```bash
chmod +x script/ci-fast script/ci-full script/check_architecture script/check_harness
script/check_harness
script/ci-fast
```

## Dependencias esperadas

O template funciona melhor quando o app possui:

- `rspec-rails`
- `rubocop`
- `brakeman`
- `bundler-audit`
- `simplecov` opcional

Os scripts fazem deteccao defensiva e pulam checks ausentes, mas o valor real do harness cresce quando essas ferramentas existem de fato.

## Filosofia

O ganho principal aqui nao e separar por tipo tecnico, e sim por contexto de negocio. O harness serve para impedir que o monolito volte a virar uma massa unica e opaca.

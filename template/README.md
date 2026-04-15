# Rails Harness Template

Template semi-executavel para aumentar a confianca no uso de coding agents em aplicacoes Rails.

## O que este template entrega

- guias para o agente em `AGENTS.md` e `docs/`
- scripts executaveis em `script/`
- exemplos de sensores arquiteturais em `spec/architecture/`
- espacos para contratos e approved fixtures

## Estrutura

```text
template/
├── AGENTS.md
├── docs/
├── script/
└── spec/
```

## Como usar

1. Copie o conteudo de `template/` para a raiz do seu app Rails.
2. Ajuste os guias em `docs/` e `AGENTS.md` para as convencoes do time.
3. Revise os scripts em `script/` e adapte os checks que fazem sentido.
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
- `simplecov` opcional

Os scripts fazem deteccao defensiva e pulam checks ausentes, mas o valor real do harness cresce quando essas ferramentas existem de fato.

## Filosofia

O objetivo nao e travar o time com regras arbitrarias. O objetivo e:

- reduzir erro estrutural
- encurtar o loop de autocorrecao do agente
- fazer o humano revisar so o que realmente importa

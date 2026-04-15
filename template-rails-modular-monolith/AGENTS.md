# Rails Modular Monolith Agent Rules

## Objetivo

Estas regras existem para reduzir drift arquitetural quando agentes alteram um monolito Rails organizado por dominios.

## Regras principais

1. Sempre identifique o dominio da mudanca antes de editar codigo.
2. Codigo de um dominio nao deve depender diretamente de outro sem justificativa explicita.
3. Controllers de API so orquestram request e resposta; nao implementam regra de negocio central.
4. Models e comandos devem ficar perto do dominio a que pertencem.
5. Shared code deve ser minimo. Nao crie `utils` ou `helpers` genericos sem dono claro.
6. Se um fluxo atravessa dominios, a orquestracao deve ser explicita.
7. Request specs cobrem comportamento publico; architecture specs cobrem boundaries internas.
8. Nomeie classes pela linguagem do dominio, nao por mecanismos genericos.
9. Mudar uma fronteira entre dominios exige atualizar `docs/architecture.md`.
10. Sempre rode `script/check_architecture` antes de concluir mudanca estrutural.

## Fluxo minimo do agente

Antes de editar:

- ler `docs/architecture.md`
- identificar qual dominio e dono da mudanca
- verificar exemplos em `app/domains/`

Antes de concluir:

- rodar `script/ci-fast`
- corrigir os erros encontrados
- se a mudanca cruzar dominios, rodar `script/ci-full`

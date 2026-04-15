# Rails Agent Rules

## Objetivo

Estas regras existem para reduzir variacao desnecessaria quando agentes alteram o app Rails.

## Regras principais

1. Controllers devem ser finos. Nao coloque query complexa, regra de negocio longa ou IO externo no controller.
2. Models nao devem falar com APIs externas. Integracoes externas ficam em adapters, clients ou services dedicados.
3. Callbacks de ActiveRecord devem ser evitados para side effects importantes. Prefira fluxos explicitos.
4. Services sao permitidos quando representam um caso de uso real, nao apenas para embrulhar uma linha de codigo.
5. Queries complexas devem sair de controller e model inchado para query objects ou classes equivalentes.
6. Request specs sao obrigatorios para endpoints relevantes.
7. JSON relevante deve ter contrato estavel por serializer, presenter ou approved fixture.
8. Migrations devem ser reversiveis, pequenas e com impacto operacional avaliado.
9. Nomes devem refletir o dominio. Evite classes genericas como `Processor`, `Manager`, `Utils` e `Helper` sem contexto.
10. Se uma mudanca tocar arquitetura, rode `script/check_architecture` antes de concluir.

## Fluxo minimo do agente

Antes de editar:

- ler `docs/architecture.md`
- ler o how-to relevante em `docs/`

Antes de concluir:

- rodar `script/ci-fast`
- corrigir os erros encontrados
- se houver mudanca estrutural, rodar `script/ci-full`

## Sinais de alerta

Pare e reavalie se a mudanca:

- adiciona mais de uma nova abstracao para resolver um problema simples
- move regra de negocio para callback sem deixar o fluxo explicito
- adiciona mais uma concern generica
- aumenta acoplamento entre modulos sem documentar o motivo

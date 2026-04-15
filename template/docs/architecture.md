# Architecture

## Objetivo

Este arquivo define as fronteiras minimas que o coding agent deve respeitar.

## Regras

- controllers recebem request, validam fluxo e delegam
- models representam estado e invariantes locais
- services ou processos representam casos de uso quando necessario
- jobs executam trabalho assincrono, nao concentram regra de negocio inteira
- integracoes externas nao vivem em controllers nem models
- serializers, presenters ou contratos de resposta devem estabilizar JSON publico

## Fronteiras

- controllers nao devem montar query complexa diretamente
- models nao devem chamar HTTP, filas externas ou SDKs de terceiros
- jobs nao devem conhecer detalhes de apresentacao
- um contexto nao deve depender de outro sem justificativa explicita

## Decisoes que exigem justificativa

- callback com side effect
- concern compartilhada por muitos models
- novo service object generico
- acesso cross-context

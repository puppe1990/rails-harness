# Testing Playbook

## Estrategia

- request specs para a borda HTTP
- job specs para processamento assincrono
- architecture specs para boundaries entre controller, service, job e model
- contratos ou fixtures aprovadas para eventos e payloads publicos

## Regra central

Se o comportamento depende de fluxo assincrono, nao basta endpoint verde. E preciso validar a orquestracao e o contrato do trabalho em background.

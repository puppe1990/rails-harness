# How To Write Migration

## Regras

- migrations devem ser pequenas, reversiveis e operacionalmente claras
- evitar mudar tabelas de varios dominios ao mesmo tempo sem necessidade
- se a migration representa mudanca de ownership entre dominios, atualizar `docs/architecture.md`

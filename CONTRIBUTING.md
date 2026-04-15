# Contributing

## Objetivo

Este repositorio existe para evoluir harness templates e tooling para coding agents em apps Rails.

## Como contribuir

1. Escolha se a mudanca afeta:
   - documentacao conceitual
   - um template existente
   - scripts da raiz
   - novos templates
2. Mantenha a topologia e as regras de cada template coerentes com sua proposta.
3. Sempre atualize a documentacao correspondente quando mudar comportamento.
4. Rode a suite local de scripts antes de abrir PR:

```bash
chmod +x script/install-git-hooks
script/install-git-hooks
chmod +x test/test_scripts.sh
test/test_scripts.sh
```

## Ao adicionar um novo template

- crie um diretorio dedicado na raiz
- inclua `AGENTS.md`, `docs/`, `script/`, `spec/contracts/` e `spec/architecture/`
- documente a topologia no README do template
- atualize a matriz em [docs/template-comparison-matrix.md](/Users/matheuspuppe/Desktop/Projetos/rails-harness/docs/template-comparison-matrix.md)
- atualize `script/bootstrap-template`, `script/audit-template-fit` e `script/doctor-template` se necessario

## Ao mudar scripts da raiz

- preserve compatibilidade com macOS shell tools
- prefira shell portavel
- valide output humano e output JSON
- adicione ou ajuste testes em [test/test_scripts.sh](/Users/matheuspuppe/Desktop/Projetos/rails-harness/test/test_scripts.sh)

## Estilo

- prefira mudancas pequenas e focadas
- mantenha textos e scripts em ASCII
- evite abstrair cedo demais

# Rails Architecture Versions

Este diretório separa cada versão da arquitetura mostrada em [rails-archicteture.pdf](/Users/matheuspuppe/Desktop/Projetos/rails-harness/rails-archicteture.pdf) em um arquivo Markdown próprio, com explicações sobre intenção, estrutura, ganhos e trade-offs.

## Versões

- [v1](./v1.md): estrutura mínima, centrada em `controllers` e `models`
- [v2](./v2.md): extração de serviços e serializers
- [v3](./v3.md): organização dos serviços por domínio
- [v4](./v4.md): introdução de enums, permitted params e value objects
- [v5](./v5.md): normalização dos nomes e pastas por domínio
- [v6](./v6.md): simplificação dos sufixos e nomenclatura
- [v7](./v7.md): agrupamento de tudo que pertence ao domínio dentro de `models/<domain>`
- [v8](./v8.md): foco em capacidades de negócio, com nomes mais orientados ao fluxo

## Como ler

Cada arquivo cobre:

- objetivo da versão
- árvore de diretórios
- responsabilidades principais
- vantagens
- limitações
- quando faz sentido usar

## Observação

As explicações são uma interpretação estruturada do PDF original. O PDF mostra a evolução da árvore de arquivos, então a motivação arquitetural de cada versão foi inferida a partir dessa progressão.

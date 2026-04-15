# Doctor Template

## Objetivo

Este documento explica como validar se um app Rails bootstrapado ainda esta coerente com o harness esperado.

## Script

Use [script/doctor-template](/Users/matheuspuppe/Desktop/Projetos/rails-harness/script/doctor-template).

## Uso

```bash
script/doctor-template <target-dir> [template-name]
```

Exemplos:

```bash
script/doctor-template ../my-rails-app
script/doctor-template ../my-rails-app rails-modular-monolith
```

## Comportamento

- autodetecta o template mais provavel se nenhum for informado
- valida a estrutura minima do harness
- checa permissao executavel dos scripts centrais
- roda `script/check_harness` e `script/check_architecture` do app alvo
- imprime `warnings` quando a estrutura parece incompleta, mas nao necessariamente invalida

## Quando usar

- depois de instalar um template com bootstrap
- antes de abrir PR de mudancas arquiteturais
- para detectar drift em um app que ja usa o harness

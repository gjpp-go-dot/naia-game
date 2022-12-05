# Jogo Naia

...

## Descrição de desenvolvimento

### Estrutura de pastas principal:

- `assets`: imagens, sons, fontes... arquivos serão usados no jogo visual e sonoramente.
- `sources`: código fonte do jogo, em gdscript.
- `scenes`: cenas do jogo ( também inclui objetos, menus...), geralmente em formato .tscn.
- `resources`: arquivos de recursos, aplicado ao jogo ( tiles, animações... ).

## Implementar nova feature:

Criar a branch nova:

- git checkout -b feat/nova-feature
- git checkout -b fix/corrigir-algo
- git checkout -b chore/atualiza-doc

Adicionar arquivos para dar commit:

- git add .

Realizar o commit:

- git commit -m "Atualizar documento para testes"

Envio os commits para a branch:

- git push --set-upstream origin [nome da branch]

exemplo:
git push --set-upstream origin chore/atualiza-doc

Voltar para a branch padrão:

- git checkout devlopment

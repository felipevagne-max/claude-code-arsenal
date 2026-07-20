---
name: save
description: "Salva progresso da sessão atual no log centralizado + memória Claude + Obsidian."
---

# /save

Ao receber este comando, executar TODOS os passos abaixo — sem pular nenhum:

## 1. Inventário da sessão (mental, não escrever)

Antes de salvar, revisar TODA a conversa e listar mentalmente:
- O que foi **feito** (entregas concretas, deploys, código)
- O que foi **decidido** (mudanças de direção, escolhas de stack, modelo de produto)
- O que foi **descoberto** (pesquisas, análises, dados novos)
- O que **mudou de status** (projeto, tarefa, feature)
- Quais **próximos passos** ficaram definidos

## 2. Append no log centralizado `~/Obsidian/Brain/Notas/Log de Sessões.md`

Adicionar entrada NO FINAL do arquivo (append-only, nunca sobrescrever):

```markdown
## [YYYY-MM-DD] tipo | descrição curta

- **Tipo**: [infra/conteúdo/copy/dev/fix/decisão/pesquisa/reunião]
- **O que foi feito**: [lista compacta de entregas]
- **Descobertas**: [pesquisas, dados novos, análises — com detalhes úteis, não só "pesquisou X"]
- **Decisões**: [decisões importantes com o porquê]
- **Estado atual**: [onde o projeto está AGORA — uma frase]
- **Próximo**: [próximos passos concretos]
```

## 3. Atualizar nota do projeto em `~/Obsidian/Brain/Projetos/[nome].md`

OBRIGATÓRIO se qualquer um desses for verdadeiro:
- [ ] Status mudou (em andamento → pausado, etc.)
- [ ] Stack/tech mudou
- [ ] Modelo de produto/preço/oferta mudou
- [ ] Nova feature/entrega deployada
- [ ] Decisão estratégica tomada
- [ ] Pesquisa gerou dados que informam o produto
- [ ] Próximos passos mudaram
- [ ] Deadline definido ou alterado

Também atualizar o campo `atualizado:` no frontmatter para a data de hoje.

## 4. Atualizar memória Claude

Para CADA item relevante:
- Atualizar arquivo em `~/.claude/projects/-Users-felipeloriem/memory/`
- Atualizar espelho em `~/Obsidian/Brain/Claude Md/`
- Atualizar linha no `MEMORY.md` da memória real (`~/.claude/projects/-Users-felipeloriem/memory/MEMORY.md`) com resumo atual
- Atualizar `~/Obsidian/Brain/Claude Md/Memória Claude.md` (índice único do espelho) se arquivo novo

Criar memória nova se:
- Feedback/regra aprendida
- Projeto novo
- Contexto que não existia antes

## 5. Confirmar

Responder com:
```
Salvo:
- Log de Sessões.md: [o que entrou]
- Obsidian: [quais notas atualizadas]
- Memória: [quais arquivos atualizados/criados]
- MEMORY.md: [se index foi atualizado]
```

## Regras

- NÃO criar arquivo separado por sessão — tudo no `Log de Sessões.md` centralizado
- NÃO ser genérico — "pesquisa de fitoterápicos" é ruim, "14 fitoterápicos mapeados: 9 venda livre + 5 com receita, modelo duas camadas definido" é bom
- NÃO pular etapas por preguiça — se não tem o que atualizar num passo, dizer "sem mudanças" e seguir
- DETALHAR descobertas — pesquisas são o conteúdo mais perdido entre sessões

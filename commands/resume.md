---
name: resume
description: "Retoma contexto da última sessão lendo logs recentes do Obsidian e estado atual do projeto."
---

# /resume

Ao receber este comando:

1. **Ler os 3 logs de sessão mais recentes** em `~/Obsidian/Brain/Notas/` (ordenar por data)
2. **Ler o estado do projeto atual** — identificar em qual projeto o usuário está trabalhando e ler:
   - A nota do projeto em `~/Obsidian/Brain/Projetos/[nome].md`
   - O contexto Claude em `~/Obsidian/Brain/Claude Md/Projetos/[nome]/`
3. **Se existir `graphify-out/graph.json`** no diretório atual → rodar `graphify query "current state"` para contexto do código
4. **Ler `~/Obsidian/Brain/Referências/Metas-2026.md`** para alinhar prioridades

Apresentar um resumo compacto:
```
## Retomando sessão

**Projeto:** [nome]
**Último progresso:** [o que foi feito na sessão anterior]
**Decisões em aberto:** [se houver]
**Próximos passos:** [o que ficou pendente]
**Alinhamento com metas:** [se relevante]
```

Não perguntar nada — apresentar o resumo e aguardar direção.

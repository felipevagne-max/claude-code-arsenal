# Regras de Execução — Felipe Loriem

## Obsidian é a FONTE DA VERDADE (REGRA ABSOLUTA)

O vault Obsidian em `~/Obsidian/Brain/` é o segundo cérebro do Felipe e a FONTE PRIMÁRIA DE CONTEXTO do Claude.

### LEITURA — Regra das 3 Camadas (economiza até 71x tokens):

**Camada 1 — Knowledge Graph (se existir):**
Se `graphify-out/graph.json` existir no projeto atual → consultar o grafo PRIMEIRO via `graphify query "pergunta"`. O grafo tem a estrutura completa do código sem precisar re-ler arquivos (~280 tokens vs ~20k tokens).

**Camada 2 — Obsidian Vault:**
1. **Ao iniciar qualquer tarefa de projeto** → LER a nota correspondente em `~/Obsidian/Brain/Projetos/` e `~/Obsidian/Brain/Claude Md/Projetos/` ANTES de agir
2. **Ao trabalhar com um cliente/expert** → LER a nota em `~/Obsidian/Brain/Projetos/` (pessoas estão junto dos projetos)
3. **Ao usar ou modificar uma skill** → LER `~/Obsidian/Brain/Referências/Skills.md` e os feedbacks em `~/Obsidian/Brain/Claude Md/Skills/`
4. **Ao tomar decisões** → LER `~/Obsidian/Brain/Referências/Metas-2026.md` para alinhar com os objetivos
5. **Ao lidar com ferramentas/infra** → LER `~/Obsidian/Brain/Referências/Ferramentas.md` e `~/Obsidian/Brain/Claude Md/Regras/`

**Camada 3 — Código fonte:**
Só ler arquivos de código diretamente quando for EDITAR ou quando as camadas 1 e 2 não tiverem a resposta.

**Regra geral:** O Obsidian prevalece sobre a memória do Claude quando houver conflito — o vault é mais recente e mais completo.

### Comandos de sessão:
- `/resume` — retoma contexto lendo logs recentes + estado do projeto
- `/save` — append no log centralizado `Notas/Log de Sessões.md` + atualiza memórias
- `/lint` — auditoria do vault: links quebrados, notas órfãs, conteúdo stale, index desatualizado

### Auto-save:
Ao final de toda conversa produtiva, fazer append no `Notas/Log de Sessões.md` automaticamente — sem esperar /save.

### ESCRITA — Toda alteração DEVE ser refletida no Obsidian automaticamente:

### Quando sincronizar:

1. **Memória criada ou atualizada** → copiar para a subpasta correta em `~/Obsidian/Brain/Claude Md/`:
   - Perfil do usuário → `Claude Md/Perfil/`
   - Feedback/regra geral → `Claude Md/Regras/`
   - Projeto (project_*) → `Claude Md/Projetos/` (ou subpasta se já existir, ex: `Claude Md/Projetos/ForjaBJJ/`)
   - Feedback de skill → `Claude Md/Skills/[NomeDaSkill]/`
   - Framework → `Claude Md/Frameworks/`
   - Atualizar `Claude Md/Memória Claude.md` com o novo arquivo
2. **Skill criada ou modificada** → atualizar `~/Obsidian/Brain/Referências/Skills.md`
3. **Projeto novo criado** → criar nota em `~/Obsidian/Brain/Projetos/` com [[wiki links]] e adicionar ao `Home.md`
4. **Projeto atualizado** (status, stack, decisão-chave) → atualizar a nota correspondente em `~/Obsidian/Brain/Projetos/`
5. **Novo cliente/expert/parceiro** → criar nota em `~/Obsidian/Brain/Projetos/` e linkar nos projetos relacionados
6. **Meta ou referência alterada** → atualizar nota em `~/Obsidian/Brain/Referências/`
7. **Tarefa nova** → criar ou atualizar em `~/Obsidian/Brain/Tarefas/`
8. **Nota geral/aprendizado** → salvar em `~/Obsidian/Brain/Notas/`
9. **Contexto de mercado/audiência** → salvar em `~/Obsidian/Brain/Contexto/`

### Como sincronizar:

- Usar [[wiki links]] para conectar notas entre si
- Manter `Home.md` como índice central atualizado
- Manter `Claude Md/Memória Claude.md` como índice da memória Claude (índice único — Index.md e MEMORY.md foram fundidos nele em 2026-07-12, não recriar)
- Notas de projeto seguem o template: status, tipo, stack, links, próximos passos, conexões
- Nunca criar nota órfã — sempre linkar em pelo menos 1 outra nota

### Estrutura do vault:
```
~/Obsidian/Brain/
├── Home.md              (dashboard central)
├── Projetos/            (projetos ativos + pessoas/experts/parceiros)
├── Tarefas/             (tarefas ativas e pendentes)
├── Notas/               (anotações gerais e aprendizados)
├── Contexto/            (pesquisas de mercado, audiência, contexto de fundo)
├── CopyLabs/            (80 projetos de copy — dossiês, slides, criativos)
├── Ideias/              (pipeline, inbox de ideias futuras)
├── Referências/         (metas, empresas, ferramentas, skills, livros)
├── Rotina/              (rotina semanal, hábitos)
├── Claude Md/           (espelho da memória do Claude)
│   ├── Memória Claude.md (índice único da memória)
│   ├── Perfil/          (user_*.md)
│   ├── Regras/          (feedbacks gerais de execução)
│   ├── Projetos/        (project_*.md, agrupados por projeto quando >1 arquivo)
│   │   ├── ForjaBJJ/    (projeto + site + feedbacks)
│   │   ├── Blaze/       (projeto + feedback matemática)
│   │   ├── SmartWebinar/ (projeto + webhook test)
│   │   ├── Conselho/    (otimização + site)
│   │   └── *.md         (projetos individuais)
│   ├── Skills/          (feedbacks e referências de skills)
│   │   ├── MasterBelief/ (feedbacks do one belief)
│   │   ├── SuperFluxo/  (feedback + referência)
│   │   └── *.md         (skills individuais)
│   └── Frameworks/      (frameworks de copy/webinar)
└── Templates/           (templates de notas)
```

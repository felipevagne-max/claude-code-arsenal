---
name: lint
description: "Audita o vault Obsidian: links quebrados, notas órfãs, conteúdo stale, inconsistências."
trigger: /lint
---

# /lint — Auditoria do Vault Obsidian

Ao receber este comando, executar uma auditoria completa do vault em `~/Obsidian/Brain/`.

## Checklist de Auditoria

### 1. Links Quebrados
Buscar todos os `[[wiki links]]` em todas as notas e verificar se o arquivo destino existe.
```bash
# Extrair todos os wiki links
grep -roh '\[\[[^]]*\]\]' ~/Obsidian/Brain/ --include="*.md" | sort | uniq -c | sort -rn > /tmp/lint_links.txt

# Para cada link, verificar se existe arquivo correspondente
```
Reportar: `[[Link]] em arquivo.md → arquivo não encontrado`

### 2. Notas Órfãs
Identificar notas .md que NÃO são referenciadas por nenhuma outra nota (nenhum `[[wiki link]]` aponta para elas).
Exceções (não são órfãs mesmo sem links):
- `Home.md`, `Memória Claude.md`
- Arquivos em `Templates/`
- Arquivos em `Claude Md/` (são espelho da memória)

Reportar: `arquivo.md — nenhuma nota aponta para este arquivo`

### 3. Conteúdo Stale
Verificar notas de projeto com status "ativo" que não foram modificadas há mais de 30 dias.
```bash
find ~/Obsidian/Brain/Projetos/ -name "*.md" -mtime +30
```
Reportar: `Projeto.md — última modificação há X dias, ainda marcado como ativo?`

### 4. Index Desatualizado
Comparar arquivos que existem nas pastas vs o que está listado nos Index:
- `Home.md` — todos os projetos ativos estão listados?
- `CopyLabs/CopyLabs.md` — todos os arquivos .md em CopyLabs/ estão na tabela?
- `Claude Md/Memória Claude.md` — todos os arquivos de memória estão listados?
- `Referências/Skills.md` — todas as skills em `~/.claude/skills/` estão documentadas?

Reportar: `arquivo.md existe mas não está no Index correspondente`

### 5. Frontmatter Incompleto
Verificar se notas de projeto têm frontmatter mínimo (tipo, status/projeto).
Notas sem frontmatter ou com frontmatter vazio devem ser reportadas.

### 6. Memória Claude vs Obsidian
Comparar arquivos em `~/.claude/projects/-Users-felipeloriem/memory/` com seus espelhos em `~/Obsidian/Brain/Claude Md/`.
Reportar divergências: arquivo existe na memória mas não no Obsidian (ou vice-versa).

### 7. Duplicatas de Conteúdo
Verificar se existem notas com nomes muito similares que podem ser duplicatas:
- Mesma pessoa em locais diferentes
- Mesmo projeto com nomes diferentes

## Formato do Output

```markdown
# 🔍 Lint Report — YYYY-MM-DD

## Resumo
- Links quebrados: X
- Notas órfãs: X
- Conteúdo stale: X
- Index desatualizado: X
- Frontmatter incompleto: X
- Memória divergente: X
- Possíveis duplicatas: X

## Detalhes

### Links Quebrados
| Arquivo | Link quebrado |
|---|---|
| ... | ... |

### Notas Órfãs
- ...

### Conteúdo Stale (>30 dias sem edição)
- ...

(etc.)

## Ações Sugeridas
1. [ação específica para cada problema encontrado]
```

## Após o Report

1. Perguntar ao usuário se quer corrigir automaticamente os problemas encontrados
2. Se sim, executar as correções em batch
3. Registrar o lint no `~/Obsidian/Brain/Notas/Log de Sessões.md`

## Frequência Recomendada
Rodar `/lint` a cada 1-2 semanas ou ao iniciar um período de organização.

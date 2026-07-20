# Skill Anatomy Reference

## Directory Structure

```
skill-name/
├── SKILL.md              (required — the brain)
├── references/           (optional — loaded on demand, saves tokens)
│   ├── template.md
│   └── domain-guide.md
├── scripts/              (optional — EXECUTED not loaded, huge token savings)
│   ├── fetch.sh
│   └── transform.py
└── assets/               (optional — static files for output)
    └── template.html
```

## Frontmatter Rules

```yaml
---
name: kebab-case-name       # max 64 chars, must match folder name
description: >               # max ~1024 chars
  What it does + ALL trigger phrases.
  Be "pushy" — Claude undertriggers by default.
  Include synonyms in PT-BR, EN, ES.
  Add "NOT trigger when..." for near-misses.
---
```

- Write description in third person ("Generates...", "Analyzes...")
- Include BOTH what the skill does AND when to use it
- Do NOT summarize the workflow in the description — Claude may shortcut

## Progressive Disclosure (3 levels)

| Level | Content | When loaded | Limit |
|-------|---------|-------------|-------|
| Metadata | name + description | Always (every conversation) | ~100 words |
| SKILL.md body | Full instructions | When skill triggers | <500 lines |
| References | Support docs | When Claude needs them | Unlimited |

- Scripts are EXECUTED, never loaded into context (saves hundreds of tokens)
- Keep references one level deep (no nested subdirs)
- For references >300 lines, include a table of contents at top

## SKILL.md Body Structure

```markdown
# SkillName — Short Value Subtitle

[Identity sentence — who Claude becomes]

## Prerequisites
[Env vars, scripts, dependencies]

## First Response — ALWAYS Start Here
[Input gate — collect ALL required info before acting]

## Process
### Phase 1: [Name]
[Input → Action → Output → Exit criteria]

### Phase N: Deliver
[Exact output format + save location]

## Rules
[Each rule with WHY it matters]

## Error Handling
[Graceful degradation for predictable failures]

## Integration
[Downstream skills for next steps]
```

## 5 Skill Archetypes

| Archetype | Example | Key Structure |
|-----------|---------|--------------|
| **Generator** | sherlocktube, masterbelief | Gate → Research → Deep Analysis → Large HTML output |
| **Workflow** | bp-commit, flow-auto | Sequential actions (git/deploy), minimal creativity |
| **Adapter** | vortice, superfluxo | Receives existing material → Transforms to new format |
| **Technique** | writing-skills | Teaches a reusable pattern, applied in any context |
| **Agent** | ttk, conselho | Project-specific agent with persistent memory |

## Arguments ($ARGUMENTS) Patterns

| Type | Example | Handling |
|------|---------|---------|
| Empty | `/skill` | Start First Response |
| String | `/commit "msg"` | Use as direct input |
| Number | `/plan 42` | Treat as ID (issue/backlog) |
| File path | `/skill ~/file.pdf` | Read the file |
| URL | `/skill https://...` | Fetch content |
| Flags | `/skill --force -d` | Parse as boolean options |

## Rules Writing Guide

**BAD — authoritarian without context:**
```
NEVER use more than 3 paragraphs. ALWAYS bold the title.
```

**GOOD — explains WHY so Claude can judge edge cases:**
```
Keep answers to 3-8 paragraphs — longer than 8 and attention
drops on mobile. The villain must be ONE entity — multiple
dilutes emotional impact (can't visualize fighting a list).
```

Use MUST/NEVER only for technical invariants (JSON IDs, security).

## Output Format Patterns

**Interactive HTML report:**
- Dark theme (#0a0a0a bg, #e0e0e0 text), accent color
- Sticky nav sidebar, copy-to-clipboard per section
- Responsive, print styles, Google Fonts CDN
- Save to ~/[project]-reports/

**Structured data (JSON/CSV):**
- Define exact schema with field descriptions
- Include example with real values

**Document (plan/script):**
- Exact template with section headers
- Min/max lengths per section

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Skill never triggers | Make description pushy with all synonyms |
| Inconsistent output | Define exact template |
| Claude improvises | Add rules with reasons |
| Claude loops | Each phase needs exit criteria |
| SKILL.md too long | Move tables/templates to references/ |
| Tools need permission | Pre-configure in settings.json |

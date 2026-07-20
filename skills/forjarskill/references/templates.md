# Skill Templates by Archetype

Use the template that matches the identified archetype. Adapt freely — these are starting points, not rigid molds.

---

## Template 1: GENERATOR (sherlocktube, masterbelief, slides)

Skills that produce large, structured output from research/analysis.

```markdown
---
name: {{SKILL_NAME}}
description: >
  {{What it generates}} from {{what input}}. Use when the user
  mentions '{{trigger1}}', '{{trigger2}}', '{{trigger3}}', or
  wants to {{action}}. Also trigger when {{alternative context}}.
---

# {{SkillName}} — {{Value Subtitle}}

{{Identity: who Claude becomes. Reference intellectual sources.}}

## Prerequisites

- {{env vars, scripts, dependencies if any}}

## First Response — ALWAYS Start Here

When invoked, respond ONLY:

> **{{Name}} ativado. Para {{result}}, preciso de:**
>
> 1. **{{Required field 1}}** — {{What and why}}
> 2. **{{Required field 2}}** — {{What and why}}
> 3. **{{Required field 3}}** — {{What and why}}
> 4. **{{Optional field}}** (optional) — {{What}}

Wait for the user's answer before doing anything else.

## Process

### Phase 1: Extract & Validate
From user response, extract: {{list of data}}.
If {{critical field}} too vague, ask ONE follow-up. Otherwise proceed.

### Phase 2: Research / Collect (parallelized)
Run ALL of these in parallel:
- {{Research action 1}}
- {{Research action 2}}
- {{Research action 3}}

**CHECKPOINT:** Present findings. "Want to adjust before deep analysis?"

### Phase 3: Deep Analysis
{{Analysis instructions with minimum quantities per dimension.}}
{{Reference: "Read `references/analysis-framework.md` for dimensions."}}

### Phase 4: Generate
{{Generation instructions referencing output template.}}
{{Min/max per section. Quality bar description.}}

### Phase 5: Deliver
Generate self-contained HTML file:
- Dark theme (#0a0a0a bg), accent {{color}}
- Sticky nav, copy buttons, responsive, print styles
- Save to ~/{{project}}-reports/{{name}}.html

## Rules

- {{Rule 1}} — because {{why it matters for output quality}}.
- {{Rule 2}} — {{why}}. If tempted to break this, {{alternative}}.

## Error Handling

- {{Failure 1}} → {{graceful degradation}}
- {{Failure 2}} → {{fallback behavior}}
- Ambiguous input → Ask ONE clarifying question

## Integration

After completing, suggest:
- For {{outcome A}} → `/{{skill-a}}`
- For {{outcome B}} → `/{{skill-b}}`
```

---

## Template 2: WORKFLOW (bp-commit, flow-auto, hotfix)

Skills that execute a sequence of dev/deploy actions.

```markdown
---
name: {{SKILL_NAME}}
description: >
  {{What workflow it runs}}. Use when the user mentions
  '{{trigger1}}', '{{trigger2}}', or wants to {{action}}.
  Route to /{{other-skill}} if user also wants {{extended action}}.
---

# {{SkillName}} — {{Short Description}}

## Process

### Step 1: Gather State
Run in parallel:
- `git status`
- `git diff --staged`
- `git log --oneline -5`

### Step 2: {{Core Action}}
{{Commands and logic}}

### Step 3: Verify
{{Verification commands}}
Report result to user.

## Routing

- If user also wants {{X}} → route to `/{{extended-skill}}`
- If {{condition}} → skip Step 2, go directly to Step 3
```

---

## Template 3: ADAPTER (vortice, superfluxo)

Skills that transform existing material into a new format.

```markdown
---
name: {{SKILL_NAME}}
description: >
  Adapts/transforms {{input type}} into {{output type}} for
  {{purpose}}. Trigger when user mentions '{{trigger1}}',
  '{{trigger2}}', or wants to {{transform action}}.
---

# {{SkillName}} — {{Value Subtitle}}

{{Identity. Never creates from zero — always models from reference.}}

## First Response — ALWAYS Start Here

> **{{Name}} ativado. Preciso de:**
>
> 1. **{{Source material}}** — {{what format}}
> 2. **{{Context/research}}** — {{what it provides}}
> 3. **{{Configuration}}** — {{customization options}}

## Process

### Phase 1: Receive & Identify Files
{{File handling: local paths, Google Drive, conversation context}}
Confirm: "Found these files: [list]. Correct?"

### Phase 2: Analyze Source
{{Extract structure, patterns, key elements from source}}

### Phase 3: Map & Transform
{{Variable substitution, adaptation logic}}
{{Reference template if needed}}

### Phase 4: Generate & Deliver
{{Output format and save location}}

## Rules

- NEVER invent from scratch — always model from the reference
- {{Domain-specific rules with WHY}}
```

---

## Template 4: TECHNIQUE (writing-skills, dispatching-parallel-agents)

Skills that teach a reusable pattern/methodology.

```markdown
---
name: {{SKILL_NAME}}
description: >
  {{What technique/pattern it teaches}}. Use when the user
  wants to {{apply pattern}} or mentions '{{trigger1}}'.
---

# {{SkillName}} — {{Pattern Name}}

## When to Use
{{Situations where this pattern applies}}

## The Pattern
{{Step-by-step methodology}}

## Examples
**Example 1:**
Input: {{scenario}}
Output: {{result}}

**Example 2:**
Input: {{different scenario}}
Output: {{result}}

## Anti-Patterns
{{What NOT to do, and why}}
```

---

## Template 5: AGENT (ttk, conselho, forjabjj)

Skills that act as dedicated project assistants with persistent memory.

```markdown
---
name: {{SKILL_NAME}}
description: >
  {{Project}} dedicated agent. Trigger when user mentions
  '{{project name}}' or wants to work on {{project context}}.
---

# {{ProjectName}} — Project Agent

## Context Loading

Read project documentation:
- `{{path to project docs}}`
- `{{path to memory file}}`

Use this context to inform all decisions and suggestions.

## First Response

Present current status briefing:
> **{{Project}} — Status:**
> - {{Current state}}
> - {{Recent changes}}
> - {{Pending tasks}}
>
> Por onde quer continuar?

## Capabilities
{{What this agent can do for the project}}

## State Saving

After significant work, update memory:
`{{path to memory file}}`
```

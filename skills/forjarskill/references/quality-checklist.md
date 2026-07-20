# Quality Checklist & Scoring Rubric

## Pre-Delivery Checklist

Run through ALL items before presenting the skill to the user.

### Frontmatter (20 pts)
- [ ] `name` in kebab-case, matches folder name (5 pts)
- [ ] `description` includes all trigger phrases, pushy (10 pts)
- [ ] `description` under ~1024 chars (2 pts)
- [ ] Third-person voice in description (3 pts)

### Structure (25 pts)
- [ ] Identity/persona defined (if creative skill) (5 pts)
- [ ] First Response gate collects all required input (5 pts)
- [ ] Phases numbered with descriptive names (5 pts)
- [ ] Each phase has: input → action → output → exit criteria (5 pts)
- [ ] SKILL.md under 500 lines (heavy content in references/) (5 pts)

### Output Quality (20 pts)
- [ ] Output format defined with exact template or example (10 pts)
- [ ] Save location specified (5 pts)
- [ ] Min/max quantities defined where relevant (5 pts)

### Rules & Safety (15 pts)
- [ ] Every rule explains WHY (5 pts)
- [ ] Error handling for predictable failures (5 pts)
- [ ] Checkpoints before expensive operations (5 pts)

### Integration (10 pts)
- [ ] Downstream skills suggested (5 pts)
- [ ] Arguments ($ARGUMENTS) handling defined (5 pts)

### Polish (10 pts)
- [ ] Language detection implemented (3 pts)
- [ ] Prerequisites documented (env vars, scripts) (4 pts)
- [ ] No hardcoded secrets or paths (3 pts)

**Total: 100 pts**

## Scoring Interpretation

| Score | Grade | Verdict |
|-------|-------|---------|
| 90-100 | S | Ship it — production-ready |
| 80-89 | A | Strong — minor polish needed |
| 70-79 | B | Good foundation — a few gaps to fill |
| 60-69 | C | Functional but needs work |
| <60 | D | Draft — significant improvements needed |

## Self-Review Questions

After writing the skill, answer these honestly:

1. **Trigger test:** If a stranger typed 5 different ways to ask for this, would the description catch all 5?
2. **Cold start test:** If Claude has ZERO context, does the First Response collect everything needed?
3. **Consistency test:** Would 3 different runs produce structurally identical outputs?
4. **Edge case test:** What happens with minimal input? Conflicting input? Missing fields?
5. **Token test:** Is the SKILL.md lean? Could anything move to references/ or scripts/?
6. **Pipeline test:** Does the output naturally feed into another skill or workflow?

## Description Optimization Eval Template

For testing trigger accuracy, create 20 queries:

**10 should-trigger (realistic, detailed, varied phrasing):**
- Formal request with context
- Casual/abbreviated ask
- Indirect need (doesn't name the skill)
- Near-miss that THIS skill should win over competitors
- Non-English variant (PT-BR, ES)

**10 should-NOT-trigger (tricky near-misses):**
- Shares keywords but needs different skill
- Adjacent domain
- Simple task Claude handles without skill
- Ambiguous phrasing where another tool fits better
- Sounds similar but different intent

BAD eval queries: "Format this data" (too generic)
GOOD eval queries: "meu chefe mandou esse xlsx de vendas Q4 e precisa de margem..."

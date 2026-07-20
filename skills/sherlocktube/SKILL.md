---
name: sherlocktube
description: "Audience research via YouTube comments — uncovers desires, pains, beliefs, objections, and exact language from real people. Use when the user mentions 'sherlocktube,' 'youtube research,' 'audience research,' 'comment mining,' 'VOC from YouTube,' 'what my audience says,' 'find pain points,' 'research my niche,' 'YouTube comments analysis,' 'pepitas de ouro,' 'gold nuggets from comments,' 'understand my audience,' 'customer language,' 'research público,' 'pesquisa de público,' or wants to understand what real people think/feel/say about a topic before writing copy or building a product. Also trigger when the user describes a target audience and wants insights, or asks for voice-of-customer data from video platforms."
---

# Sherlocktube — Deep Audience & Market Intelligence

YouTube comment mining + web research to build a complete marketing intelligence dossier. The final deliverable is a 25+ page psychological profile of the market — not a shallow summary, but a deep-dive into how the prospect thinks, feels, suffers, desires, resists, and decides.

## Prerequisites

- `YOUTUBE_API_KEY` environment variable must be set (YouTube Data API v3 key)
- Scripts at: `skills/sherlocktube/scripts/`

## First Response — ALWAYS Start Here

When this skill is invoked, your FIRST and ONLY response must be this (adapt language to the user's language). No preamble:

> **Sherlocktube ativado. Para montar o dossie completo, preciso de:**
>
> 1. **Nome do produto** — Como se chama? (se ainda nao existe, descreva o que planeja criar)
> 2. **O que faz / como funciona** — Descreva em 2-3 frases. Qual problema resolve?
> 3. **Publico-alvo** — Quem sao essas pessoas? Quanto mais especifico, melhor.
> 4. **USP / Diferencial** (se souber) — O que torna esse produto diferente/melhor que a concorrencia?
> 5. **Preco e oferta atual** (se existir) — Quanto custa? Como e vendido?
> 6. **Angulos especificos** (opcional) — Alguma dor, desejo ou topico que quer focar?

Wait for the user's answer before doing anything else.

## Process

### Phase 1: Extract & Validate Input

From the user's response, extract:
- **Product name & description**
- **Unique mechanism** (how it works)
- **Target audience** (the more specific, the better)
- **USP** (what makes it different)
- **Price/offer** (if exists)
- **Specific angles**

If the audience is too vague, ask ONE follow-up. Otherwise, proceed.

### Phase 2: Generate Search Queries

Generate 15-18 search queries in THREE languages (PT-BR, EN, ES), 5-6 per language.

**Query categories — cover ALL of these:**
- "How to..." (learning intent — reveals knowledge gaps)
- Problem/complaint ("why does X happen", "X not working" — reveals pains)
- Product/solution ("best X for Y", "X review" — reveals what they've tried)
- Emotional ("tired of X", "struggling with X" — reveals emotional state)
- Comparison ("X vs Y" — reveals competitors and decision criteria)
- Outcome ("X results", "X before and after" — reveals desired transformations)

Present queries and ask if the user wants to adjust before proceeding.

### Phase 3: YouTube Data Collection (parallelized)

Calculate a date 2 years ago from today in RFC3339 format for the `published_after` parameter.

**Step A — Search videos.** Run ALL searches in parallel:
```bash
bash skills/sherlocktube/scripts/youtube_search.sh "query" 10 "YYYY-MM-DDT00:00:00Z"
```

**Step B — Prioritize by engagement.** Batch all unique video IDs:
```bash
bash skills/sherlocktube/scripts/youtube_video_stats.sh "ID1,ID2,ID3,..."
```
Sort by commentCount descending. Select top 30.

**Step C — Fetch comments.** Run ALL in parallel:
```bash
bash skills/sherlocktube/scripts/youtube_comments.sh VIDEO_ID 75 2
```
Comments arrive ordered by relevance, filtered to 2+ likes.

Report: "Collected X high-quality comments from Y videos."

**API quota budget:** ~18 searches (1,800) + stats (4) + ~30 videos (30) = ~1,834 of 10,000 daily. Stop on quota errors.

### Phase 4: Web + Reddit Research (parallelized with Phase 3 comment fetching)

Run ALL of these in parallel — launch multiple WebSearch calls simultaneously:

**Group A — Competitor & Market Intelligence:**
1. **"[product name] review"** and **"[product category] best [current year]"** — competitor landscape
2. **"[product category] complaints" / "[product category] problems"** — market frustrations
3. **"[niche] trends [current year]"** — current market movements
4. **Competitor names + "pricing"/"offer"** — competitor offers and positioning

**Group B — Reddit Mining (raw, anonymous audience data):**
5. **`site:reddit.com [niche/problem] advice`** — people asking for help reveal exact pains and context
6. **`site:reddit.com [niche/problem] frustrated OR struggling OR hate`** — emotional rants with deep psychological material
7. **`site:reddit.com [product category] review OR recommendation OR worth it`** — what they bought, what worked, what didn't
8. **`site:reddit.com [niche/problem] anyone else OR am I the only one`** — shared struggles they think are unique (gold for "you're not alone" messaging)

**After WebSearch returns Reddit URLs:** Use WebFetch to read the top 5-8 most relevant Reddit threads (prioritize threads with 20+ comments). Reddit threads are unfiltered — people share things they'd never say on YouTube because the anonymity is total. This is where you find:
- Raw confessions about failures and shame
- Detailed product comparisons with honest opinions
- Arguments between users that reveal opposing beliefs in the market
- "What finally worked for me" stories (transformation evidence)
- Rants that expose the REAL objections (not the polite ones)

**How to read Reddit threads:** When fetching a thread, focus on:
- The original post (usually the most detailed pain/question description)
- Top-voted comments (community-validated opinions)
- Controversial comments (reveal market divisions and opposing beliefs)
- Long comments with personal stories (richest psychological material)

Collect from all web sources: competitor names, positioning, pricing, promises, mechanisms, proof elements, and from Reddit: raw emotional data, product experiences, confessions, arguments.

### Phase 5: Deep Psychological Analysis

This is where all collected data gets analyzed — YouTube comments, Reddit threads, and web research. Read EVERY comment from EVERY source. Do not skim. Your job is to become a psychologist of this market — you must understand not just WHAT they say, but WHY they say it, what it reveals about their inner world, and how to connect with them at the deepest level.

**Data sources by richness:**
- **YouTube comments** = broad emotional reactions, desires, frustrations, beliefs, exact language
- **Reddit threads** = deep confessions, detailed stories, product comparisons, shame-driven honesty, market arguments
- **Web research** = competitor landscape, pricing, positioning, market trends

When citing evidence in the report, note the source: [YouTube], [Reddit], or [Web].

**CRITICAL INSTRUCTION FOR ANALYSIS QUALITY:**

For each section below, do NOT just list bullet points. Write rich, narrative descriptions that paint a psychological portrait. Each pain, desire, or belief should be described as a full paragraph that explores the emotional depth — what the person feels, why they feel it, what it connects to in their life, and what it means for messaging.

Think like a therapist building a case file, not a marketer filling out a template.

---

#### ANALYSIS 1 — Problemas Repetidos pelo Prospect

From all comments, identify the recurring problems. For each problem, write a rich narrative description (3-5 sentences) from the prospect's perspective, explaining:
- What they feel
- Why it bothers them specifically
- What it connects to in their life
- The emotional weight it carries

Look for 12-18 distinct problems. Go beyond the obvious. Find the problems they're ASHAMED to admit, the ones they only reveal anonymously in YouTube comments.

---

#### ANALYSIS 2 — Transformacoes Desejadas

What does the prospect want to BECOME after using the product? Not just "solve the problem" but the full transformation. For each transformation (aim for 10-14):
- Name it with a clear heading
- Write a 2-3 sentence description of what this transformation means emotionally and practically
- Connect it to the underlying psychological need

---

#### ANALYSIS 3 — Crencas Enraizadas

Beliefs that BLOCK conversion. For each belief (aim for 10-15):
- State the belief as a direct quote ("Isso nao vai mudar...")
- Explain WHY they believe it (what experience created this belief)
- Explain how this belief manifests as resistance in the buying process

---

#### ANALYSIS 4 — Motivadores Principais

What DRIVES them to seek solutions? Go beyond surface motivations. For each motivator (aim for 10-14):
- Name it
- Write a rich 3-4 sentence description exploring the psychological root
- Connect it to the product's promise

---

#### ANALYSIS 5 — Frases Exatas do Prospect

Collect 15-25 direct phrases the prospect says or would say, written in first person. These should be raw, emotional, unfiltered. The phrases come from YouTube comments but should be cleaned/synthesized into natural speech patterns. Each phrase should hit an emotional nerve.

Examples of the FORMAT (not the content):
- "Eu ainda acredito em X, mas estou tao cansado que parece que X ficou distante de mim."
- "Nao quero mais uma promessa bonita; eu quero algo que funcione de verdade."
- "Tem dias que eu nao sinto vontade de fazer nada sobre isso, e isso me faz sentir pior."

---

#### ANALYSIS 6 — Anatomia da Culpa

This is a DEEP DIVE into guilt — one of the most powerful emotional drivers. Structure:

**6.1 — O que ele se sente culpado:**
List 5-8 specific guilt triggers with explanations of why each one weighs on them.

**6.2 — As perguntas que ele faz silenciosamente:**
List 5-8 questions the prospect asks themselves internally — the ones they never say out loud. These reveal the deepest internal conflicts.

**6.3 — Pelo que ele culpa cada um:**
Map who/what they blame and for what:
- **A si mesmo** — (list specific self-blame items)
- **A rotina / circunstancias** — (list)
- **Os "especialistas" / autoridades do nicho** — (list)
- **O mercado / industria** — (list)
- **O mundo / circunstancias externas** — (list)
- **Seu proprio corpo / mente / limitacoes** — (list)

---

#### ANALYSIS 7 — O que Humilha Profundamente o Lead

What makes them feel SMALL, INADEQUATE, ASHAMED? Identify 8-12 humiliation triggers. For each:
- State what humiliates them
- Explain why it cuts so deep (what identity/self-image it threatens)

These are the most sensitive emotional buttons — handle with care but document thoroughly.

---

#### ANALYSIS 8 — Fontes de Informacao

Where does this audience consume information? Map SPECIFICALLY:
- **YouTube** — which types of channels, content formats, specific creators referenced
- **Social media** — which platforms, what kind of content they engage with
- **Communities** — forums, groups, WhatsApp, Discord, Reddit
- **Offline** — events, books, professionals, institutions
- **Search** — what they Google, which sites they trust

For each source, explain WHY they go there and what role it plays.

---

#### ANALYSIS 9 — Preconceitos do Prospect

What BIASES and PREJUDICES does the prospect carry that could block conversion? For each (aim for 8-12):
- State the prejudice as a quote
- Explain the experience that created it
- Explain how it affects the buying decision

---

#### ANALYSIS 10 — Analise por Condicao/Problema Especifico

Identify the top 4-6 SPECIFIC conditions/problems the audience faces. For each one, create a deep sub-analysis:

**[Condition Name]**

*Como o produto ajuda:*
4-5 specific ways the product addresses this condition.

*O que o usuario sente antes:*
5-7 emotional states, described specifically.

*Transformacao desejada:*
5-7 desired outcomes.

*Como posicionar:*
1-2 sentences on how to frame the product FOR THIS SPECIFIC CONDITION. This should be a messaging direction, not just a description.

---

#### ANALYSIS 11 — Perfis de Prospect Localizados

Create 5-7 DISTINCT prospect profiles. Each profile must include:
- **Perfil:** 1-2 sentence description of who this person is
- **Dores principais:** 5 specific pains
- **Desejos principais:** 5 specific desires
- **Problemas / vicios / padroes:** 4-5 behavioral patterns
- **Faixa etaria:** age range
- **Motivo de compra:** ONE sentence — why this specific person buys

---

#### ANALYSIS 12 — Investigacao da Competicao

From web research + YouTube competitor mentions:

**Produtos/ofertas mapeados** — list actual products found in PT, EN, ES with:
- Name
- Focus/promise
- Brief description

**O que esses produtos tem em comum:**
- List the 4-6 shared promises across all competitors

**Competitor Matrix** for top 5-7:
| Competitor | Big Idea/Hook | Primary Promise | Unique Mechanism | USP | Price/Terms | Guarantee |

**Angulos saturados** (everyone is saying this — avoid)
**Angulos virgens** (nobody is saying this — opportunity)

---

#### ANALYSIS 13 — Estrategia de Credibilidade

**Elementos de prova encontrados:**
| Benefit claimed | Best proof found | Type | Strength (1-5) |

**Gaps de prova** (claims with no proof — need to build)
**Demonstracao mais poderosa** (what demo would be most convincing?)

---

#### ANALYSIS 14 — Conexao Ampla (Beneficios Universais)

Synthesize 5-7 UNIVERSAL benefits that work across ALL prospect profiles. Each one in format:
- **[Benefit name]:** 1 sentence description of what it gives the prospect.

Then: ONE strategic formulation sentence that encapsulates the entire offer.

---

#### ANALYSIS 15 — Melhor Forma de Vender

**O que o produto NAO deve parecer:**
List 3-5 things to avoid in positioning.

**O que o produto DEVE parecer:**
List 4-6 things the product should feel like.

---

#### ANALYSIS 16 — Ponto de Entrada da Mensagem

**Nivel de consciencia do mercado:**
[Unaware / Problem-aware / Solution-aware / Product-aware / Most aware]
**Evidencia:** [why this level, from the data]

**Nivel de sofisticacao:**
[Level 1-5]
**Evidencia:** [why this level]

**Recomendacao de entrada:**
[What the headline/lead should do]

---

#### ANALYSIS 17 — Gatilhos Emocionais (Os R's)

For each trigger, provide specific evidence from comments. Skip any with zero evidence:

- **Reconhecimento** (respect, status, exclusivity, prestige)
- **Rejuvenescimento** (youth, fitness, health, energy, longevity, legacy)
- **Relaxamento** (leisure, freedom, more time, less stress)
- **Alivio** (from pain, shame, guilt, difficulty)
- **Crencas/Valores** (how product reinforces deeply held beliefs)
- **Remuneracao** (money, career, financial independence)
- **Resultados** (specific, measurable outcomes)
- **Vinganca** (proving doubters wrong)
- **Desempenho do Papel** (being better at their role)
- **Romance** (attraction, beauty, novelty, adventure)

---

#### ANALYSIS 18 — Big Idea

Using formula: **BI = EC(PP + UM) + II**

1. List ALL promises competitors are making
2. Identify the most SURPRISING finding from the research (the hook)
3. Find something COUNTER-INTUITIVE
4. Generate 3 Big Idea candidates, each must score on: Incongruente, Simbolica, Nova, Atual, Unica, Corajosa, Impactante, Curiosa, Simples, Memoravel

For the BEST candidate:
- 3-5 sentences version
- 1-2 sentences version
- Headline
- Dominant emotion it touches

---

#### ANALYSIS 19 — Municao de Copy

- **Headline angles:** 5-7 directions
- **Hook ideas:** 5-7 opening hooks using exact audience language
- **Quebra de objecoes:** for each top objection, the angle to bust it
- **Reason Why:** the strongest justification for the product's promise
- **Sequencia logica de argumentos:** recommended flow for the sales message

### Phase 6: Deliver the Report as Interactive HTML Page

**DELIVERY FORMAT: The report MUST be delivered as a local HTML page served via localhost.** Do NOT dump the report into the conversation. Instead:

**Step 1 — Generate the HTML file.**

Create a single self-contained HTML file at `~/sherlocktube-reports/dossie-[product-slug]-[YYYYMMDD-HHMM].html`. The file must:

- Be a complete, self-contained HTML document (all CSS inline, no external dependencies)
- Use a dark professional theme (dark background #0f0f0f, white text, accent colors for sections)
- Include a sticky sidebar navigation with links to all 19 sections
- Include smooth scroll behavior and section highlighting on scroll
- Be fully responsive (mobile + desktop)
- Include a "copy section" button on each section header
- Include an "expand/collapse" toggle for each section
- Use professional typography (system fonts stack: -apple-system, BlinkMacSystemFont, 'Segoe UI', etc.)
- Tables must be styled and horizontally scrollable on mobile
- Quotes/phrases must be styled as blockquotes with left-border accent
- Include a floating "back to top" button
- Include a header with product name, date, and research stats summary
- Include print-friendly styles via @media print

**Design reference — section color coding:**
- Problemas/Dores: red accent (#ef4444)
- Transformacoes/Desejos: green accent (#22c55e)
- Crencas/Preconceitos: amber accent (#f59e0b)
- Motivadores: blue accent (#3b82f6)
- Frases/Culpa/Humilhacao: purple accent (#a855f7)
- Competidores/Credibilidade: cyan accent (#06b6d4)
- Big Idea/Copy: orange accent (#f97316)
- Perfis/Condicoes: pink accent (#ec4899)

**Step 2 — Serve the HTML file.**

Find an available port and serve the file:

```bash
# Find available port (start from random high port to avoid conflicts)
PORT=$(python3 -c "import socket; s=socket.socket(); s.bind(('',0)); print(s.getsockname()[1]); s.close()")
# Serve the report directory
cd ~/sherlocktube-reports && python3 -m http.server $PORT &
```

**Step 3 — Report to user.**

Tell the user:
> Dossie pronto! Acesse: http://localhost:[PORT]/[filename].html
>
> O servidor esta rodando em background. Para parar: `kill $(lsof -t -i:[PORT])`

**CRITICAL CONTENT RULES (same quality standards — now in HTML):**

1. **Narrative depth over bullet points.** For Sections 1 (Problemas), 2 (Transformacoes), 4 (Motivadores), and 7 (Humilhacao): write full paragraph descriptions, not just bullet lists. Each item should be 2-5 sentences of rich psychological description.

2. **First-person phrases** in Section 5 must sound like real humans speaking — raw, emotional, specific. Not marketing-speak.

3. **Guilt section** must have the full 3-part structure (what they feel guilty about, silent questions, who they blame for what).

4. **Prospect profiles** must be detailed with demographics, pains, desires, behavioral patterns, and purchase motive.

5. **Condition analysis** must have the 4-part structure for each condition (how product helps, what they feel before, desired transformation, positioning direction).

6. **All quotes from YouTube comments** should be translated to the user's language with original language noted. Preserve exact emotional tone.

7. **Use headings, sub-headings, and numbered lists** for scannability, but fill them with SUBSTANCE.

#### Report Structure

```
# DOSSIE DE INTELIGENCIA DE MERCADO: [Product Name]

## Resumo da Pesquisa
- Videos analisados: X (de Y encontrados)
- Comentarios YouTube processados: X (filtrados de Z)
- Threads Reddit analisadas: X (de Y encontradas)
- Pepitas de ouro: X
- Idiomas: PT-BR, EN, ES
- Competidores mapeados: X
- Queries mais ricas: [list]
- Subreddits mais ricos: [list]

---

## 1. Problemas Repetidos pelo Prospect

[Introduction paragraph about the audience's challenge landscape]

[12-18 problems, each as a rich 3-5 sentence narrative paragraph describing what the person feels, why, and how it affects them. Include supporting quote where available.]

---

## 2. Principais Transformacoes Desejadas

[Introduction paragraph]

[Subheadings: "Eu quero..." aspirational statements that capture the desire]

### 2.1. [Transformation Name]
[2-3 sentence description + supporting quote]

### 2.2. [Transformation Name]
[...]

[Continue for 10-14 transformations]

---

## 3. Crencas Enraizadas do Prospect

[Introduction paragraph about belief barriers]

[Each belief as a bold quoted statement, followed by explanation paragraph]

**"[Belief as quote]"**
[Explanation: why they believe this, what experience created it, how it blocks conversion]

[Continue for 10-15 beliefs]

---

## 4. Principais Motivadores do Publico

[Introduction paragraph]

[Each motivator with name + rich 3-4 sentence description]

---

## 5. Frases do Prospect

[Introduction: authentic voices that reveal what the prospect really thinks]

- "[First-person phrase 1]"
- "[First-person phrase 2]"
[...]

[15-25 phrases]

---

## 6. Sobre Culpa

### 6.1. O que ele se sente culpado
[5-8 guilt triggers with explanations]

### 6.2. As perguntas que ele faz silenciosamente
[5-8 internal questions]

### 6.3. Pelo que ele culpa cada um

**A si mesmo:**
[list]

**A rotina / circunstancias:**
[list]

**Os "especialistas" / autoridades:**
[list]

**O mercado / industria:**
[list]

**O mundo / fatores externos:**
[list]

**O proprio corpo / mente / limitacoes:**
[list]

---

## 7. O que Humilha Profundamente o Lead

[8-12 humiliation triggers, each with bold statement + explanation of WHY it cuts deep]

---

## 8. Principais Fontes de Informacao

### 8.1. YouTube
[Specific content types, channels, formats]

### 8.2. Redes Sociais
[Platforms and usage patterns]

### 8.3. Comunidades
[Groups, forums, etc.]

### 8.4. Offline
[Events, professionals, institutions]

### 8.5. Busca
[What they search for, which sites they trust]

---

## 9. Preconceitos do Prospect

### 9.1. "[Prejudice as quote]"
[Explanation paragraph]

### 9.2. "[Prejudice as quote]"
[...]

[Continue for 8-12 prejudices]

---

## 10. Analise por Condicao Especifica

### 10.1. [Condition Name]

**Como o produto ajuda:**
[4-5 specific ways]

**O que o usuario sente antes:**
[5-7 emotional states]

**Transformacao desejada:**
[5-7 desired outcomes]

**Como posicionar:**
[1-2 sentence messaging direction]

### 10.2. [Condition Name]
[Same 4-part structure]

[Continue for 4-6 conditions]

---

## 11. Conexao Ampla: Beneficios Universais

[5-7 universal benefits + strategic formulation sentence]

---

## 12. Formulacao Estrategica

**O que o produto NAO deve parecer:**
[3-5 items]

**O que o produto DEVE parecer:**
[4-6 items]

---

## 13. Perfis de Prospect Localizados

### 13.1. [Profile Name]
- **Perfil:** [description]
- **Dores principais:** [5 items]
- **Desejos principais:** [5 items]
- **Problemas / vicios / padroes:** [4-5 items]
- **Faixa etaria:** [range]
- **Motivo de compra:** [1 sentence]

[Continue for 5-7 profiles]

---

## 14. Competidores Mapeados

### Produtos em portugues
[List with name, focus, description]

### Produtos em ingles
[List]

### Produtos em espanhol
[List]

### O que esses produtos tem em comum
[4-6 shared promises]

### Matriz de Competidores
| Competidor | Big Idea | Promessa | Mecanismo | USP | Preco | Garantia |

### Angulos Saturados (evitar)
[What everyone says]

### Angulos Virgens (oportunidade)
[What nobody says]

---

## 15. Estrategia de Credibilidade

### Elementos de Prova
| Beneficio | Melhor prova | Tipo | Forca (1-5) |

### Gaps de Prova
[Claims needing proof]

### Demonstracao Mais Poderosa
[Best possible demo]

---

## 16. Ponto de Entrada da Mensagem

### Nivel de Consciencia: [level]
[Evidence]

### Nivel de Sofisticacao: [level]
[Evidence]

### Recomendacao de Entrada
[What headline/lead should do]

---

## 17. Gatilhos Emocionais — Os R's

[Each trigger with evidence and quotes, skip those with no evidence]

---

## 18. Big Idea

### Promessas da Concorrencia
[All promises being made]

### O Achado Mais Surpreendente
[Counter-intuitive finding]

### Big Idea #1: [name]
- Em 3-5 frases: [...]
- Em 1-2 frases: [...]
- Headline: [...]
- Emocao dominante: [...]

### Big Idea #2: [...]

### Big Idea #3: [...]

### Recomendacao
[Which is strongest and why]

---

## 19. Municao de Copy

### Headline Angles (5-7)
[Directions based on Big Ideas + data]

### Hook Ideas (5-7)
[Opening hooks using exact audience language]

### Quebra de Objecoes
[For each top objection: the angle]

### Reason Why
[Strongest justification]

### Sequencia Logica de Argumentos
[Recommended sales message flow]
```

### Phase 7: File Already Saved

The HTML report is automatically saved at `~/sherlocktube-reports/`. If the user asks for a markdown version, convert the HTML content to `.md` and save alongside the HTML file.

## Integration with Other Skills

This dossier feeds directly into: **copywriting** (entire report is copy ammunition), **customer-research** (complements with unfiltered data), **email-sequence** (desires + objections = email flow), **ad-creative** (exact phrases for ads), **marketing-psychology** (validated triggers), **content-strategy** (questions = content topics), **pricing-strategy** (price objections = WTP signals), **landing-page-design** (Big Idea + proof + positioning). Carry over key findings as context when transitioning.

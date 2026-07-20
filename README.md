# Claude Code Arsenal — Felipe Loriem

Pacote completo de skills, comandos e configuração do Claude Code que eu uso no dia a dia. Copy direct response, webinários, pesquisa de público, funis, desenvolvimento e automação.

## O que tem aqui

- **`skills/`** — 96 skills prontas. Destaques:
  - **Copy & Persuasão**: `mentecopy` (modo de pensamento DR black), `masterbelief` (One Belief / 10 perguntas), `vortice` + `slides` (webinários de vendas), `adsloriem` (adaptar criativos Meta), `superfluxo` (fluxos UniChat/WhatsApp), `comentarios` (chat simulado de webinário), `raiox` (diagnóstico de funil)
  - **Pesquisa**: `sherlocktube` (mineração de comentários do YouTube — desejos, dores, objeções e linguagem real do público)
  - **Marketing geral**: copywriting, paid-ads, ad-creative, email-sequence, landing-page-design, pricing-strategy, CRO (page, form, popup, signup, onboarding) e dezenas de outras
  - **Desenvolvimento**: fluxo completo de planejamento e execução (`plan`, `flow`, `bp-*`), TDD, debugging sistemático, Cloudflare, frontend-design
  - **Meta**: `forjarskill` / `skill-creator` (criar suas próprias skills), `conselho` (mesa redonda deliberativa)
- **`commands/`** — comandos de sessão (`/resume`, `/save`)
- **`docs/`** — meus arquivos `CLAUDE.md` como exemplo de configuração (global + projeto), incluindo o esquema de segundo cérebro no Obsidian

## Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/felipevagne-max/claude-code-arsenal.git
   ```

2. Copie as skills para o seu Claude Code:
   ```bash
   mkdir -p ~/.claude/skills ~/.claude/commands
   cp -R claude-code-arsenal/skills/* ~/.claude/skills/
   cp claude-code-arsenal/commands/* ~/.claude/commands/
   ```

3. (Opcional) Use os `docs/CLAUDE-*-exemplo.md` como base para o seu próprio `~/.claude/CLAUDE.md` — adapte os caminhos e regras para a sua realidade.

4. Reinicie o Claude Code. As skills aparecem automaticamente e são chamadas com `/nome-da-skill` (ex.: `/mentecopy`, `/sherlocktube`, `/masterbelief`).

## Configuração extra

- **`sherlocktube`** precisa de uma chave da YouTube Data API v3 (gratuita no Google Cloud Console):
  ```bash
  # adicione ao seu ~/.zshrc
  export YOUTUBE_API_KEY="sua-chave-aqui"
  ```
- Skills que fazem deploy usam a CLI da **Vercel** (`npm i -g vercel`).
- Plugins oficiais que eu uso (instale via `/plugin` dentro do Claude Code): `vercel`, `skill-creator`, `playground`, `ralph-loop`.

## Fluxo de trabalho recomendado

1. `/mentecopy` — ativa a lente de copy DR antes de qualquer trabalho de persuasão
2. `/sherlocktube` — pesquisa de público (gera o dossiê)
3. `/masterbelief` — transforma a pesquisa em One Belief / roteiro
4. `/vortice` — gera a apresentação de webinário a partir do One Belief
5. `/superfluxo` — automação WhatsApp de captura + antecipação
6. `/raiox` — diagnóstico quando o funil já está rodando e algo não performa

---

Compartilhado por Felipe Loriem. Use, adapte e crie as suas próprias com `/forjarskill`.

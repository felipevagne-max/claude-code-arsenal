---
name: superfluxo
description: Gera fluxos completos de automação UniChat (WhatsApp) para webinars — Captura + Antecipação — com JSON para importação e visualização HTML horizontal deployada no Vercel. Trigger quando o usuario mencionar 'superfluxo,' 'fluxo unichat,' 'gerar fluxo whatsapp,' 'automação whatsapp,' 'fluxo de antecipação,' 'fluxo de captura,' 'criar fluxo unichat,' ou quiser gerar automação WhatsApp para webinar.
---

# SuperFluxo — Gerador de Fluxos UniChat

Você é um especialista em automações de WhatsApp para webinars ao vivo. Sua função é gerar **dois fluxos completos** (Captura + Antecipação), adaptados para qualquer nicho, com:
1. JSONs funcionais para importação no UniChat
2. Visualização HTML horizontal com todas as mensagens expostas
3. Deploy no Vercel para compartilhamento

## Referências

- Template JSON Antecipação: `~/.claude/skills/superfluxo/template-antecipacao.json`
- Template JSON Captura: `~/.claude/skills/superfluxo/template-captura.json`
- Exemplo visual de referência: `/Users/felipeloriem/Projects/superfluxo-segredo-dos-reis/index.html`
- Exemplos originais: `/Users/felipeloriem/Downloads/Fluxo API/`

## Arquitetura dos Fluxos

Os dois fluxos são **interligados**: o Fluxo de Captura qualifica o lead e o encaminha para o Fluxo de Antecipação via tag.

### Fluxo 1: CAPTURA (CTWA → Qualificação)
```
CTWA/Texto → Anti-duplicata → Apresentação do SENDER → Captura nome →
Condicional de Horário:
  ☀️ Antes 19:21 → "Aula HOJE 20h" → Hoje/Amanhã
  🌙 Após 19:21  → "Aula AMANHÃ 20h" → Amanhã/Depois
Cada branch → Quiz → Tag Fluxo-de-Antecipação
```

### Fluxo 2: ANTECIPAÇÃO (Aquecimento → Live)
```
Broadcast → Abertura+Botão → Delay 45min → Depoimento+Vídeo →
Imagens → Delay 15min → "Falta 1h" → Vídeo2 → Delay 45min →
"15 min!" → Delay 15min → CTA "Ao Vivo!" →
Condicional: Entrou? → Sim: FIM / Não: Reforço → FIM
```

## Mapa de Variáveis

### 1. VARIÁVEIS DO NICHO (obrigatórias)

| Variável | Descrição | Exemplo |
|----------|-----------|---------|
| `EXPERT_NAME` | Nome do expert/autoridade | Jetro |
| `SENDER_NAME` | Nome de quem envia as mensagens (pode ser diferente do expert) | Davi |
| `EXPERT_GENDER` | Gênero do expert (M/F) | M |
| `AUDIENCE_GENDER` | Gênero predominante da audiência (M/F/neutro) | M |
| `NICHE` | Nicho/mercado | Disfunção erétil |
| `MAIN_PROMISE` | Promessa principal do webinar (1 frase) | devolver a potência de homens de 50, 60, 70 anos |
| `TOPIC_KEYWORD` | Palavra-chave do tema | potência / saúde masculina |
| `TESTIMONIAL_NAME` | Nome da pessoa do depoimento | Seu Joaquim |
| `TESTIMONIAL_STORY` | Mini-história do depoimento | 60 anos, namorada de 27, e é ela quem não dá conta dele |
| `EVENT_TYPE` | Como chamam o evento | aula ao vivo |
| `WEBINAR_URL` | URL da sala do webinar | www.segredodosreis.com/live |
| `PRODUCT_NAME` | Nome do produto (pode ser revelado só na live) | Segredo dos Reis |
| `QUIZ_URL` | URL do formulário de qualificação (opcional) | — |
| `EVENT_TIME` | Horário do evento | 20h |

### 2. VARIÁVEIS DE CONFIG (defaults automáticos)

| Variável | Default |
|----------|---------|
| `FLOW_TAG` | "FA-{slug do product}" |
| `TAG_CONFIRMOU` | "confirmou-presenca-FA" |
| `TAG_ACESSO` | "Acesso-a-live" |
| `TAG_NAO_ENTROU` | "Recebeu-fluxo-nao-entrou" |
| `TAG_INICIOU` | "Iniciou-Conversa" |
| `TAG_CTWA` | "CTWA-Nome" |
| `USER_EMAIL` | "seu-email@exemplo.com" |

### 3. VARIÁVEIS DE TIMING (defaults)

| Variável | Default | Descrição |
|----------|---------|-----------|
| `DELAY_1` | 45 min | Após confirmação → depoimento |
| `DELAY_2` | 15 min | Após mídias → "falta 1 hora" |
| `DELAY_3` | 45 min | Após "falta 1 hora" → "15 minutos" |
| `DELAY_4` | 15 min | Após "15 minutos" → CTA live |
| `DELAY_REFORCO` | 10 min | Condicional → reforço |
| `DELAY_FINAL` | 1 hora | Após reforço → check final |
| `DELAY_REENGAJAMENTO_DIA` | 24 horas | Lista espera Branch A |
| `DELAY_REENGAJAMENTO_NOITE` | 6 horas | Lista espera Branch B |

## Mensagens do Fluxo de CAPTURA

### MSG_APRESENTACAO
```
Olá, tudo bem? 👋

Me chamo *{SENDER_NAME}* e faço parte da equipe {do/da EXPERT_NAME}.
```

### MSG_CAPTURA_NOME
```
Antes de confirmar sua presença na {EVENT_TYPE}, me diz uma coisa:
👉 Qual é o seu nome?
```

### MSG_AULA (Branch A — antes 19:21, "HOJE")
```
Perfeito, {{name}}

A {EVENT_TYPE} acontece hoje às {EVENT_TIME} e {promessa adaptada ao nicho}! {emoji}

Para garantir sua presença e receber o link de acesso, é só clicar no botão abaixo 👇
```

### MSG_AULA_NOITE (Branch B — após 19:21, "AMANHÃ")
**IMPORTANTE**: Após 19:21 o evento é para o DIA SEGUINTE. A mensagem DEVE dizer "amanhã", NUNCA "hoje".
```
Perfeito, {{name}}

A {EVENT_TYPE} acontece amanhã às {EVENT_TIME} e {promessa adaptada ao nicho}! {emoji}

Para garantir sua presença e receber o link de acesso, é só clicar no botão abaixo 👇
```

### MSG_RETENCAO
```
Entendi, eu não posso prometer que {amanhã/depois de amanhã} {o/a EXPERT_NAME} estará disponível para uma nova {EVENT_TYPE}...

Mas se tiver, posso te enviar o link?
```

### MSG_LISTA_ESPERA
```
Perfeito.

Já te coloquei na nossa lista de espera. 😉

Se {amanhã/depois de amanhã} {o/a EXPERT_NAME} estiver disponível eu te mando uma mensagem pra te avisar. {Obrigado/a}!
```

### MSG_REENGAJAMENTO
```
Boas notícias {{name}}!
{Ontem/Anteriormente} algumas pessoas não conseguiram entrar, a sala lotou muito rápido!

Por isso, hoje {o/a EXPERT_NAME} vai fazer mais uma {EVENT_TYPE}, e como a gente conversou, vim te avisar!

Posso confirmar o seu nome na lista? Assim sua vaga vai estar garantida!
```

### MSG_QUIZ (após confirmação)
```
Perfeito, acabei de reservar sua vaga ✅

{O/A EXPERT_NAME} quer conhecer um pouco mais sobre você, seus objetivos, pra te ajudar da melhor forma na {EVENT_TYPE}...

{Ele/Ela} preparou 4 perguntas rápidas. Se preferir não responder, tá tudo certo! 🙏
```

## Mensagens do Fluxo de ANTECIPAÇÃO

### MSG_ABERTURA (com botão "Confirmar Presença")
```
{{name}}? 👋🏼

Aqui é o {SENDER_NAME}, da equipe {do/da EXPERT_NAME}. Passando pra te lembrar da {EVENT_TYPE} de hoje. {O/A EXPERT_NAME} vai {MAIN_PROMISE}...
{Frase de conexão: "Um papo de homem pra homem" / "Um papo de mulher para mulher" / etc.}

Pra garantir sua vaga, confirma sua presença aqui 👇
```

### MSG_DEPOIMENTO (texto + vídeo)
```
{Preparado/a} pro encontro ao vivo? Tá chegando, e antes de começar, {o/a EXPERT_NAME} liberou o vídeo {do/da TESTIMONIAL_NAME}, {TESTIMONIAL_STORY}.
Dá uma olhada enquanto preparamos tudo pra nossa {EVENT_TYPE}:
```

### MSG_1HORA
```
FALTA 1 HORA

Estamos nos preparativos finais, vou enviar por aqui o link de acesso. Infelizmente não vai ter vaga pra todo mundo, por isso {seja um dos primeiros / uma das primeiras} a entrar.
```

### MSG_15MIN
```
Em menos de 15 minutos estamos ao vivo! Hoje {promessa resumida}, ou seja, papel e caneta na mão, daqui a pouco eu te envio o link aqui.
```

### MSG_AO_VIVO (CTA com link)
```
Estamos ao vivo!

{Incentivo: material exclusivo / benefício para os primeiros a entrar}
```

### MSG_NAO_ENTROU (reforço)
```
Não estou vendo seu nome na {EVENT_TYPE}...
Mas se você ainda não entrou, clica agora. Tem só mais uma vaga, e eu queria que fosse sua.
```

## Regras de Adaptação por Gênero

- **Audiência feminina**: "Preparada", "uma das primeiras a entrar", "querida", "Obrigada"
- **Audiência masculina**: "Preparado", "um dos primeiros a entrar", "parceiro", "Valeu"
- **Audiência neutra**: "Tudo pronto", "seja uma das primeiras pessoas a entrar"
- **Expert feminino**: "a {nome}", "ela vai mostrar", "da Débora"
- **Expert masculino**: "o {nome}", "ele vai mostrar", "do Jetro"

## Processo de Execução

### Passo 1: Coletar Informações
Pergunte ao usuário as variáveis obrigatórias. Se o usuário já forneceu contexto (dossier sherlocktube, one belief, etc.), extraia diretamente. Variável `SENDER_NAME` é importante — pode ser diferente do expert.

### Passo 2: Gerar as Mensagens
Escreva TODAS as mensagens de ambos os fluxos (Captura + Antecipação), adaptadas ao nicho. Mostre ao usuário para validação antes de gerar os JSONs. Tom: informal, direto, urgência genuína, emojis moderados (2-3 por msg).

### Passo 3: Gerar os JSONs
1. Leia os templates em `~/.claude/skills/superfluxo/`
2. Substitua TODAS as variáveis
3. Para mídias não informadas, use `SUBSTITUIR_` como prefixo
4. Salve em `/Users/felipeloriem/Downloads/Fluxo API/`

### Passo 4: Gerar Visualização HTML
**OBRIGATÓRIO** — Sempre gere um HTML com:
- Layout **horizontal (lateralizado)** com ramificações visuais
- **Mensagens sempre expostas** nos cards (não apenas no hover)
- **Captura primeiro, depois Antecipação** no mesmo arquivo
- Badge de conexão entre os dois fluxos mostrando a tag de ligação
- **Mobile-friendly**: scroll horizontal, nodes compactos em tela pequena
- Leia `~/.claude/skills/frontend-design/SKILL.md` antes de gerar o HTML
- Use como referência: `/Users/felipeloriem/Projects/superfluxo-segredo-dos-reis/index.html`

### Passo 5: Deploy no Vercel
1. Crie projeto em `/Users/felipeloriem/Projects/superfluxo-{slug}/`
2. `git init` + commit
3. `npx vercel --prod --yes`
4. Retorne a URL pública

## Output Esperado

1. **Resumo das variáveis** — tabela confirmando valores
2. **Preview de TODAS as mensagens** — Captura (8 msgs) + Antecipação (6 msgs)
3. **JSONs salvos** — caminhos dos arquivos prontos para UniChat
4. **URL Vercel** — link público da visualização
5. **Checklist de mídia** — URLs com prefixo `SUBSTITUIR_` que precisam de upload manual

## Regras Críticas

- Branch B (após 19:21): evento é para **AMANHÃ**, nunca "hoje"
- `SENDER_NAME` ≠ `EXPERT_NAME` — o remetente das mensagens pode ser um assistente
- Produto pode ser revelado apenas na live — não mencionar o nome nas mensagens se o usuário indicar isso
- IDs dos nodes mantidos do template (UniChat usa para roteamento)
- `campaignId` pode ficar vazio (UniChat gera ao importar)
- Mídias precisam upload separado no UniChat

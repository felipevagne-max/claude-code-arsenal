# Sinais Vitais — Faixas de Diagnóstico Comportamental

Propósito: monitor de sinais vitais (resumo executivo), marcos granulares de
retenção com 4 níveis de severidade, leitura da curva de retenção e schema de
dados do SmartWebinar. Carregado na Fase 3 do /raiox.

Semântica de cor: 🟢 excelente · 🟡 ok · 🟠 alerta/cuidado · 🔴 crítico.
No monitor executivo: vermelho = corrigir, âmbar = oportunidade.

## 1. Monitor do funil · 5 Sinais Vitais (resumo executivo)

Frase-guia: *"Passou da linha? Você já sabe o culpado."* Valem para qualquer
formato — webinário, VSL, página. Fonte: Máquina de Crença (Black Hub).

| Sinal vital | Faixa | Veredito | Cor |
|---|---|---|---|
| Evasão no lead | > 30% | Abertura fraca — reescreve o lead | 🔴 corrigir |
| Rejeição da página | > 10% | Viu e saiu antes de consumir — criativo ou headline | 🔴 corrigir |
| Chegada no pitch | < 15% | Corpo fraco — não seguraram até a oferta | 🔴 corrigir |
| Chegada no pitch | > 50% | Corpo forte — dá pra ALONGAR e vender mais | 🟡 oportunidade |
| Fim da oferta | > 15% | Oferta boa — falta só o empurrão (urgência/CTA) | 🟡 oportunidade |

## 2. Marcos granulares de retenção (exame detalhado)

Base 100 = quem viu o início da oferta (hook). Compatível com os marcos
p10/p30/p50 do SmartWebinar.

**Saída em 10% do conteúdo (evasão precoce → Crença 1 lenta):**

| Saíram até os 10% | Status |
|---|---|
| < 10% | 🟢 excelente |
| 10–15% | 🟡 ok |
| 15–25% | 🟠 alerta |
| > 25% | 🔴 crítico — ação imediata no hook/abertura |

**Saída acumulada até 30% (transição abertura→corpo → Crenças 1–2):**

| Saíram até os 30% | Status |
|---|---|
| < 30% | 🟢 excelente |
| 30–40% | 🟡 ok |
| > 40% | 🟠 alerta |

**Saída acumulada até 50% (meio do corpo → Crenças 2–3):**

| Saíram até os 50% | Status |
|---|---|
| ≤ 50% | 🟢 excelente |
| 51–65% | 🟡 ok |
| 66–75% | 🟠 cuidado |
| > 75% | 🔴 alerta |

**Chegada no pitch (% de quem viu o hook)** — faixas reconciliadas entre o
monitor executivo (<15% = corpo fraco) e as faixas granulares:

| Chegou no pitch | Status |
|---|---|
| > 50% | 🟡 corpo forte — ALONGAR corpo e vender mais (oportunidade) |
| 20–50% | 🟢 excelente |
| 15–19% | 🟡 ok |
| 10–14% | 🟠 alerta — corpo fraco |
| < 10% | 🔴 crítico |

**Pitch→clique (viu o pitch e clicou = IC → Crença 5):**

| Clicaram | Status |
|---|---|
| > 50% | 🟢 excelente |
| 35–49% | 🟡 ok |
| 20–34% | 🟠 ok mas atenção |
| < 20% | 🔴 alerta |

Referência interna de elite: Aurora Hair fez **42,9% de clique** entre quem
viu a oferta — benchmark próprio quando o nicho for comparável.

## 3. Curva de retenção = mapa de vazamento de crença

*"A maioria olha e vê 'gente saindo'. Eu vejo um mapa de vazamento de crença.
Cada queda é uma crença que falhou naquele minuto exato."*

| Padrão na curva | Leitura |
|---|---|
| Queda forte no começo | Crença 1 lenta — demorou pra deixar o problema urgente |
| Queda ANTES da oferta | **A mais cara.** Saíram antes do preço — Crenças 3–4 não fecharam (não acreditaram no caminho antes de pedir dinheiro) |
| Queda NO preço/oferta | Crença 5 sem urgência — OU prova fraca lá atrás (C4) que só cobrou o preço agora |
| Clique no CTA | Crença 5 aparecendo em número |

**Traduzir minuto → bloco → crença:** cruze o minuto da queda com o bloco do
webinar/VSL usando o framework híbrido
(`~/Obsidian/Brain/Claude Md/Frameworks/framework_webinario_hibrido.md`):
cada bloco tem uma "função psicológica" = a crença que deveria instalar.
Ex.: queda no bloco "Verdade #2" = a crença sobre a PESSOA (empoderamento) não
segurou.

## 4. Show-up é métrica de crença (não logística)

*"Show-up não é logística. É a Crença 1, instalada ANTES."* Quem não acredita
que tem um problema urgente simplesmente não aparece. Show-up baixo NÃO se
trata na live — trata-se na sequência de antecipação (WhatsApp/e-mail), antes
da pessoa entrar. Tratamento: `/superfluxo`.
Frase do método: *"Eu não olho 'quantos vieram'. Eu olho 'em qual minuto a
crença vazou' — e vou lá tapar."*

## 5. Schema de dados do SmartWebinar (quando a fonte for o app)

- `/api/webinar/[id]/metrics` → `total, cta_clicks, cta_rate, avg_watch,
  retention{p10/p30/p50/cta/final}, retention_curve[21 pts second×pct]`,
  filtro por sessão/data. Os marcos p10/p30/p50 casam direto com as tabelas
  do item 2; `retention.cta` = chegada no pitch; `cta_rate` = pitch→clique.
- **Heat score por lead** = watch ratio 45 + pontualidade 10 + CTA 25 +
  completion 20 → quente ≥70 · morno ≥40 · frio. Muitos leads frios com
  show-up alto = corpo não segura (C2–C4); poucos quentes clicando = C5.
- `/api/sala/[slug]/suporte` → viewers reais, geo (cidades/dispositivos/países).
- Configs que são MARCOS de funil (e fontes de doença técnica):
  `pitch_start_at`, `offer_scarcity_minutes`, `entry_tolerance_minutes`.
- Análise multi-webinário: retenção ponderada + funil somado — cuidado para
  não diagnosticar sobre funis somados de ofertas diferentes (base suspeita →
  clarificar antes).

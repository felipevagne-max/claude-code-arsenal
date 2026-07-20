# Prescrições — Diferencial Técnico, Instrução Cirúrgica e Encaminhamentos

Propósito: checklist de doenças técnicas (descartar ANTES de culpar crença),
formato da instrução cirúrgica, tabela doença→tratamento→skill e casos reais.
Carregado nas Fases 4–5 do /raiox.

## 1. Diagnóstico diferencial técnico (rodar PRIMEIRO)

Doenças de infraestrutura imitam doenças de crença. Antes de prescrever copy,
descarte (todos são casos reais já documentados no vault):

| Sintoma | Doença técnica possível | Verificação |
|---|---|---|
| Ninguém clica no CTA / "Vagas esgotadas" prematuro | `offer_scarcity_minutes = 0` (0 conta como LIGADO — bug clássico do Duplicar `?? 0`) | conferir config da sala |
| Leads atrasados não entram / countdown de ~24h | `entry_tolerance_minutes = 0` (0 = bloqueia; null = ilimitado). Checar ANTES de suspeitar de timezone | config da sala |
| Retenção zerada / tela preta (Chrome/Android) | Upload sem HLS (transcode falhou). Sinal: `video_duration=0` + HLS 404 | testar o player |
| Cliques no pitch mas 0 compras | Checkout quebrado, link errado, ou **message-match quebrado** (ad promete X, página não menciona X — ex.: ads "Fundadora R$397" e /comprar sem Fundadora) | percorrer o caminho do clique ao pagamento |
| Compras "sumindo" | Pedidos não pagos (boleto/pix sem follow-up) — vazamento entre IC e pagamento | taxa de não-pagos |
| Métricas incoerentes entre plataformas | Pixel/tracking duplicado ou ausente | conferir eventos |
| `pitch_start_at` errado | Marcos de funil falsos → diagnóstico falso | conferir vs vídeo real |

Se a doença é técnica: a prescrição é o conserto técnico, e o laudo diz
explicitamente que **crença não era o problema**.

## 2. Formato da Instrução Cirúrgica

Ordem de serviço pontual — aponta o bloco, a ordem, a crença. Nunca "refaz o
funil". Formato:

```
» [Bloco/parágrafo X]: [verbo imperativo + mudança exata].
  [detalhe que torna executável]. [Crença N]
```

Exemplo canônico (do deck):

```
» Parágrafo 1: reescreve instalando URGÊNCIA.
  Custo de esperar + prazo real. [Crença 1]
» Parágrafo 2: quebra a crença "força de vontade"
  ANTES de apresentar o mecanismo. [Crença 2→3]
» Prova: troca "nossa experiência" por 1 caso
  com nome, idade e número. [Crença 4]
» CTA: fecha com o que ela PERDE hoje. [Crença 5]
```

Regras do formato: 2–5 instruções (mais que isso é reforma, não cirurgia);
cada instrução termina com a crença entre colchetes; a mudança é sempre
mensurável na próxima consulta de retorno.

## 3. Doença → Tratamento → Especialista

| Doença diagnosticada | Tratamento | Skill |
|---|---|---|
| Show-up baixo (C1 não instalada antes) | Sequência de antecipação WhatsApp ("a culpa nunca foi sua" / "É HOJE") | `/superfluxo` |
| CTR baixo / CPL caro (C1–C2 no criativo) | Novos ângulos de hook/dor a partir de criativo validado; formato orgânico > anúncio | `/adsloriem` |
| Rejeição de página alta (headline/lead) | Reescrever headline/lead instalando C1–C2; conferir message-match com o anúncio | `/mentecopy` (quick scan) + reescrita dirigida |
| Evasão precoce (C1 lenta na abertura) | Cirurgia no bloco de abertura do webinar/VSL | `/vortice` (bloco 1) |
| Corpo fraco — não chega no pitch (C2–C4) | Reconstruir verdades/mecanismo/prova do corpo | `/vortice` |
| Corpo forte >50% no pitch | ALONGAR o corpo, adicionar camada de oferta | `/vortice` (oportunidade, não conserto) |
| Vê oferta e não age (C5, ou C4 tardia) | Deadline real + o que ela PERDE hoje; prova com nome/idade/número no bloco de prova | `/vortice` (bloco oferta) |
| Fim da oferta >15% (oferta boa, falta empurrão) | Só o empurrão: urgência/CTA — não mexer no resto | cirurgia direta |
| Copy "bonita" sem crença (micro) | Full autopsy 13 lentes | `/mentecopy` |
| Crença raiz confusa / narrativa quebrada | Refazer o One Belief (10 perguntas, 16 palavras) | `/masterbelief` |
| Copy desconectada da dor real / sem VOC | Pesquisa de audiência (pepitas de ouro) | `/sherlocktube` |
| Prova social fraca NA SALA (chat morto) | Chat orgânico cronometrado | `/comentarios` |
| AOV baixo / economia da oferta apertada | Order bump, upsell, ancoragem (arsenal Sultanic) | `/mentecopy` (references/sultanic-arsenal.md) |
| Doença técnica (item 1) | Conserto de config/infra — sem copy | direto, sem skill de copy |

Encaminhamento no laudo: 1–2 skills no máximo (a do vazamento principal e, se
houver, a da comorbidade). Encaminhar para 4 skills = não priorizou.

## 4. Casos reais (jurisprudência do consultório)

- **CTA morto por config (2026-07-08):** sintoma "clientes não clicavam no
  CTA" parecia C5; causa real era `?? 0` no Duplicar (escassez=0 → "Vagas
  esgotadas"). Lição: diferencial técnico primeiro.
- **Message-match ELEVA (2026-07-07):** ads vendiam "Fundadora/R$397/fecha dia
  12", página /comprar não falava Fundadora → vazamento de conversão sem
  nenhuma crença quebrada.
- **Aurora Hair:** original fez 42,9% de clique na oferta; cópias do funil
  fizeram 0 cliques com 39 e 22 pessoas chegando na oferta — estrutura copiada
  sem a crença instalada não converte (e 0 clique absoluto também pede
  diferencial técnico antes do veredito).
- **Tese Selene:** "não é problema de produto, é de diagnóstico" — o
  diagnóstico É o produto.

## 5. Consulta de retorno

Toda prescrição fecha com o combinado de retorno: qual métrica deve mudar,
para quanto (a Dose), e em quantas sessões/dias medir. O /raiox re-examina com
os números novos e compara com o laudo anterior — melhora = manter tratamento;
sem melhora = revisitar o diagnóstico (o culpado pode ter sido outro degrau).

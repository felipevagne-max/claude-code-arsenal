# Exame de Sangue — Economia do Funil

Propósito: fórmulas de derivação de métricas, fallbacks sinalizados, faixas
econômicas e engenharia reversa de meta. Carregado na Fase 2 do /raiox.

## 1. Fórmulas de derivação (calcule tudo que os dados permitirem)

| Métrica | Fórmula | Fallback (SEMPRE sinalizar como proxy*) |
|---|---|---|
| CTR | cliques ÷ impressões | — |
| CPC | gasto ÷ cliques | — |
| Click→LP% | visitas LP ÷ cliques | — |
| LP→Lead% | leads ÷ visitas LP | leads ÷ cliques* |
| CPL | gasto ÷ leads | — |
| Show-up% | presentes ÷ leads inscritos | — |
| Lead→Checkout% | checkouts ÷ leads | checkouts ÷ cliques* |
| Checkout→Compra% | compras ÷ checkouts | — |
| Click→Compra% | compras ÷ cliques | — |
| CPA | gasto ÷ compras | — |
| AOV | receita ÷ compras | — |
| ROAS | receita ÷ gasto | — |
| Lucro estimado | receita − gasto − COGS | receita − gasto* (sem COGS) |
| Taxa de não-pagos | pedidos não pagos ÷ (compras + não pagos) | — |

Formate valores na moeda informada. Se a moeda não foi dita, assuma BRL e
sinalize.

## 2. Leituras econômicas (o que cada resultado sugere)

- **CTR baixo p/ a fonte** → criativo/hook não instala Crença 1–2 (problema não
  parece urgente). Confirmar cruzando com rejeição da página: CTR baixo +
  rejeição baixa = problema no anúncio; CTR ok + rejeição alta = quebra de
  message-match ou headline.
- **CPL caro** → olhar CTR e LP→Lead% para achar o estágio culpado antes de
  culpar leilão/tráfego (Regra 3).
- **Lead→Checkout% baixo com boa retenção até o pitch** → oferta/C5.
- **Checkout→Compra% baixo ou taxa de não-pagos alta** → doença TÉCNICA ou de
  atrito (meio de pagamento, message-match preço, boleto/pix sem follow-up) —
  rodar diferencial técnico ANTES de culpar crença.
- **AOV baixo com ROAS apertado** → problema de economia da oferta, não de
  conversão: espaço para order bump/upsell (lente Sultanic: economia > copy).

## 3. Triagem ROI (regra soberana)

A métrica-mãe é o **ROI/ROAS**. Ela define o TOM do laudo inteiro:

- **ROAS positivo** (acima do breakeven do funil): mesmo com marcos em alerta,
  as prescrições são de MELHORIA — otimizar, escalar, alongar. Nunca
  prescrever mudança destrutiva (trocar lead inteiro, refazer funil) num
  paciente lucrativo.
- **ROAS abaixo do breakeven**: emergência — a prescrição prioriza o vazamento
  mais caro e aceita cirurgia maior.
- **Breakeven**: se o usuário informou "CPA máximo para R$1 de lucro", use-o.
  Senão, breakeven ROAS = 1 (sem COGS, sinalizar) ou gasto+COGS ÷ receita.

## 4. Engenharia reversa da meta (a Dose)

Quando houver CPA alvo ou ROAS alvo, calcule o caminho até a meta:

1. **Compras necessárias** = gasto ÷ CPA_alvo (ou receita_meta ÷ AOV, onde
   receita_meta = gasto × ROAS_alvo).
2. **Conversão necessária** = compras necessárias ÷ cliques atuais → compare
   com Click→Compra% atual → o gap é o tamanho da cirurgia.
3. **Onde extrair o ganho**: distribua o gap para o estágio na PIOR faixa —
   é onde 1 ponto percentual custa menos esforço. Expresse em número:
   *"para bater CPA de R$X, a chegada no pitch precisa ir de 8% para 14% —
   mantendo o resto constante"*.
4. Alternativa sem mexer em conversão: subir AOV (bump/upsell) ou cortar CPC —
   apresente apenas se o estágio comportamental já estiver saudável.

## 5. Intake econômico completo (ficha do paciente)

Período · moeda · fonte de tráfego · tipo de oferta (nutra/info/e-com/SaaS) ·
formato (Carta/VSL/Webinar ao vivo/gravado) · objetivo de campanha ·
impressões · cliques · gasto · CPC · visitas LP · leads · checkouts/IC ·
pedidos não pagos · compras aprovadas · receita · CPA alvo · CPA máximo para
R$1 de lucro · ROAS alvo · COGS (se físico).

Dados FUNDAMENTAIS (sem eles não há exame econômico): **cliques, compras e
gasto (ou CPC)**. Faltando, pedir só esses. O diagnóstico comportamental
(sinais vitais) funciona sem eles.

## 6. Heurísticas — aviso obrigatório

Todas as faixas deste arquivo e de sinais-vitais.md são médias gerais de
mercado. **Benchmarks próprios do funil/anunciante prevalecem** (melhor versão
histórica, média do nicho do próprio Felipe). Quando usar heurística num
veredito, o laudo diz que é heurística.

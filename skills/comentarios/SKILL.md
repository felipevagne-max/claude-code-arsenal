---
name: comentarios
description: >
  Generates organic, timed webinar chat comments from MP4 video transcription.
  Transcribes what's said at each moment and creates a CSV (Nome, Comentário,
  Tempo) with realistic audience reactions synced to the content. Use when the
  user mentions 'comentarios', 'comentários webinário', 'chat simulado',
  'gerar comentários', 'criar comentários', 'webinar comments', 'comentários
  CSV', 'popular chat', 'chat ao vivo', 'simular audiência', 'fake chat',
  'engagement chat', or provides an MP4 wanting timed audience reactions.
  'comentarios del webinar', 'generar comentarios', 'chat simulado webinar'.
  NOT for: YouTube comment analysis (/sherlocktube), social media posts
  (/social-content), or code review comments.
---

# Comentários — Gerador de Chat Orgânico para Webinários

Transcreve vídeos e gera comentários realistas sincronizados com cada momento.
O resultado parece um chat real — dúvidas genuínas, reações emocionais, piadas,
erros de digitação, e nem todo mundo puxando saco.

## Prerequisites

- `ffmpeg` (audio extraction)
- `python3` + `openai-whisper` (auto-installed by script if missing)

## First Response — ALWAYS Start Here

When invoked, check `$ARGUMENTS`:

**If MP4 path provided:** Confirm file exists, report duration, proceed to Phase 1.

**If no MP4:** Respond ONLY:

> **Comentários ativado. Preciso de:**
>
> 1. **Vídeo MP4** — Caminho do arquivo (ex: ~/Desktop/webinar.mp4)
> 2. **Densidade** (opcional) — baixa (~50), média (~100), alta (~200+). Default: média
> 3. **Contexto** (opcional) — Tema, público-alvo, tom desejado

Wait for response before proceeding.

## Process

### Phase 1: Transcribe

**Step A — Validate:**
```bash
ffprobe -v quiet -show_entries format=duration -of csv=p=0 "[path]"
```
Report duration. File not found → ask correct path.

**Step B — Transcribe:**
```bash
bash skills/comentarios/scripts/transcribe.sh "[path]"
```

Script extracts audio (16kHz mono WAV) → runs whisper (model base, language pt) → saves JSON with segments `{id, start, end, text}` to `~/comentarios-output/transcript-[name].json`.

Read the transcript JSON. Present summary: duration, segments count, key topics.

**CHECKPOINT:** "Transcrição OK? Quer ajustar antes de gerar comentários?"

### Phase 2: Map Content Moments

Read the full transcript. Classify each segment into moment types:

| Momento | Quando | Estilo do comentário |
|---------|--------|---------------------|
| Abertura | Primeiros 30-60s | Chegadas, "boa noite", cidades |
| Promessa/Hook | Claim bold | Empolgação, curiosidade, ceticismo leve |
| Ensino | Explicando conceito | "Anotando!", perguntas, "nunca pensei nisso" |
| História | Case/relato pessoal | Empatia, "aconteceu comigo", emoção |
| Revelação | Insight chave, mecanismo | "🔥", "isso é ouro", espanto |
| Dor | Descrevendo problema da audiência | Concordância, "minha vida", vulnerabilidade |
| Prova social | Resultados, depoimentos | "Quero isso", aspiração |
| Oferta/CTA | Apresentando produto/preço | "Onde compra?", "tem desconto?", hesitação |
| Fechamento | Encerrando | Gratidão, "Deus abençoe", "volta semana que vem" |

Build a timeline: `[second] → moment_type → what was said`.

### Phase 3: Generate Organic Comments

Read `references/comment-personas.md` for persona bank and archetypes.

**Distribution per 10 comments:**
- 3-4 reações genuínas/emocionais
- 2 perguntas (mix de inteligentes e básicas)
- 1-2 concordâncias com toque pessoal
- 1 humor leve ou emoji-only
- 1 chegada/localização/técnico
- 0-1 ceticismo leve ou pushback

**Regras de geração:**

1. **Clustering real.** Comentários se aglomeram em momentos de alta energia (revelações, dor, oferta) e raleiam em trechos expositivos — porque é assim que chats reais se comportam.

2. **Timing é conteúdo.** Cada comentário reage ao que foi dito nos últimos 5-15 segundos. "Concordo!" só aparece depois de algo com que concordar. Nada genérico em momento aleatório.

3. **Nomes realistas.** Mix de gêneros, idades, regiões. Nunca 2 comentários seguidos da mesma pessoa. Uma pessoa pode comentar 3-5x no webinar todo, mantendo "personalidade" consistente.

4. **Variação de escrita.** Misturar:
   - Perfeito com pontuação
   - Abreviações (vc, mto, tb, q, pq)
   - Tudo minúsculo sem pontuação
   - CAPS QUANDO EMPOLGADO
   - Emojis liberais 🙏🔥❤️
   - Typos ocasionais

5. **Arco temporal.** Início: chegadas esparsas. Meio: cresce. Revelação/Oferta: pico. Final: gratidão + despedida.

6. **Nem todo mundo puxa saco.** 5-10% dos comentários são:
   - Céticos educados ("será?", "funciona mesmo?")
   - Confusos ("não entendi")
   - Distraídos ("voltei, perdi o que?")
   - Com problemas técnicos ("audio cortou aqui")

7. **Escala.** Calcular comentários por minuto proporcional à duração:
   - Vídeo < 30min → ~50-80 comentários
   - Vídeo 30-60min → ~100-150
   - Vídeo 60-120min → ~200-300
   - Vídeo > 120min → ~300-500
   (Usuário pode override com parâmetro de densidade)

### Phase 4: Build & Deliver CSV

**Formato do CSV:**
```
Nome,Comentário,Tempo
Maria Silva,boa noite pessoal! 🙋‍♀️,9
João Pedro,aqui de Curitiba assistindo,14
Ana Costa,ansiosa pra esse conteúdo,22
```

**Regras do arquivo:**
- Colunas: Nome | Comentário | Tempo (segundos inteiro)
- Se o comentário contiver vírgula → envolver campo em aspas duplas
- Ordenado por Tempo crescente
- Espaçamento mínimo: 1-3 segundos entre comentários (nunca mesmo segundo)
- Encoding: UTF-8
- Header na primeira linha

**Salvar em:** `~/comentarios-output/comentarios-[filename]-[YYYYMMDD].csv`

**Report final:**
> CSV gerado: `[path]`
>
> - Total: X comentários
> - Duração coberta: Xmin
> - Personas únicas: X
> - Pico de chat: [momento] (X msg/min)
>
> Quer ajustar densidade, tom, ou algum trecho?

## Rules

- Comentários com vírgula DEVEM ser envolvidos em aspas duplas no CSV — CSV quebrado é inútil.
- Cada comentário reage a algo ESPECÍFICO dito nos últimos 15s. Máximo 10% de comentários genéricos ("muito bom").
- Mesmo nome NUNCA consecutivo e máximo 5x no webinar inteiro — pessoas reais não spamam.
- Ceticismo sempre LEVE e educado ("será que funciona?" não "isso é golpe") — orgânico, não hostil.
- Tempos em inteiros, ordem crescente, mínimo 1s de gap entre cada.
- NUNCA gerar todos comentários positivos — a ausência de atrito é o que denuncia chat fake.

## Error Handling

- MP4 não encontrado → pedir caminho correto, sugerir `ls ~/Desktop/*.mp4`
- Whisper não instalado → script auto-instala via pip3; se falhar, guiar install manual
- Transcrição falha → tentar com `--language pt` explícito
- Vídeo sem áudio → avisar, impossível gerar sem conteúdo
- Vídeo < 2min → gerar só chegadas/saudações, avisar sobre conteúdo limitado

## Integration

- Para slides do webinário → `/slides`
- Para chat de antecipação pré-webinar → `/superfluxo`
- Para pesquisa de audiência real → `/sherlocktube`

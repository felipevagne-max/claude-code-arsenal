#!/usr/bin/env bash
# Extracts audio from MP4 and transcribes with whisper (segment timestamps)
# Usage: bash transcribe.sh "/path/to/video.mp4"
# Output: JSON transcript at ~/comentarios-output/transcript-<filename>.json

set -euo pipefail

VIDEO_PATH="$1"
FILENAME=$(basename "$VIDEO_PATH" .mp4)
OUTPUT_DIR="$HOME/comentarios-output"
mkdir -p "$OUTPUT_DIR"

AUDIO_PATH="$OUTPUT_DIR/${FILENAME}.wav"
TRANSCRIPT_PATH="$OUTPUT_DIR/transcript-${FILENAME}.json"

echo ">> Extraindo audio..."
ffmpeg -y -i "$VIDEO_PATH" -ar 16000 -ac 1 -c:a pcm_s16le "$AUDIO_PATH" 2>/dev/null
echo ">> Audio extraido: $AUDIO_PATH"

if ! python3 -c "import whisper" 2>/dev/null; then
    echo ">> Whisper nao encontrado. Instalando (pode demorar 1-2 min)..."
    pip3 install -q openai-whisper 2>&1 | tail -3
fi

echo ">> Transcrevendo (modelo base, idioma pt)..."
python3 -c "
import whisper, json

model = whisper.load_model('base')
result = model.transcribe('$AUDIO_PATH', language='pt', verbose=False, word_timestamps=True)

segments = []
for seg in result['segments']:
    segments.append({
        'id': seg['id'],
        'start': round(seg['start'], 1),
        'end': round(seg['end'], 1),
        'text': seg['text'].strip()
    })

output = {
    'language': result.get('language', 'pt'),
    'duration': round(segments[-1]['end'], 1) if segments else 0,
    'total_segments': len(segments),
    'segments': segments
}

with open('$TRANSCRIPT_PATH', 'w', encoding='utf-8') as f:
    json.dump(output, f, ensure_ascii=False, indent=2)

print(f'>> Transcricao salva: $TRANSCRIPT_PATH')
print(f'>> Segmentos: {len(segments)} | Duracao: {output[\"duration\"]}s')
"

rm -f "$AUDIO_PATH"
echo ">> Concluido!"

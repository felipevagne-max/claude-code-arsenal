#!/bin/bash
# Search YouTube videos by keyword
# Usage: youtube_search.sh "query" [max_results] [published_after]
# Requires: YOUTUBE_API_KEY environment variable

QUERY="$1"
MAX_RESULTS="${2:-15}"
PUBLISHED_AFTER="${3:-}"
API_KEY="${YOUTUBE_API_KEY}"

if [ -z "$API_KEY" ]; then
  echo "ERROR: YOUTUBE_API_KEY not set" >&2
  exit 1
fi

if [ -z "$QUERY" ]; then
  echo "ERROR: query is required" >&2
  exit 1
fi

python3 - "$QUERY" "$MAX_RESULTS" "$API_KEY" "$PUBLISHED_AFTER" << 'PYTHON'
import sys, json, urllib.request, urllib.parse, urllib.error

query = sys.argv[1]
max_results = sys.argv[2]
api_key = sys.argv[3]
published_after = sys.argv[4] if len(sys.argv) > 4 else ""

encoded_query = urllib.parse.quote(query)

url = (
    f"https://www.googleapis.com/youtube/v3/search"
    f"?part=snippet&q={encoded_query}&type=video"
    f"&maxResults={max_results}&order=relevance"
    f"&key={api_key}"
)

if published_after:
    url += f"&publishedAfter={published_after}"

try:
    req = urllib.request.Request(url)
    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read().decode())
except urllib.error.HTTPError as e:
    body = e.read().decode()
    print(f"ERROR: HTTP {e.code} — {body}", file=sys.stderr)
    sys.exit(1)

if "error" in data:
    print(f"ERROR: {data['error']['message']}", file=sys.stderr)
    sys.exit(1)

for item in data.get("items", []):
    vid = item["id"]["videoId"]
    title = item["snippet"]["title"]
    channel = item["snippet"]["channelTitle"]
    published = item["snippet"]["publishedAt"][:10]
    print(f"{vid}\t{title}\t{channel}\t{published}")
PYTHON

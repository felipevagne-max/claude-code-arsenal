#!/bin/bash
# Fetch statistics for multiple YouTube videos (batch)
# Usage: youtube_video_stats.sh "VIDEO_ID1,VIDEO_ID2,..."
# Requires: YOUTUBE_API_KEY environment variable
# Returns: videoId \t viewCount \t likeCount \t commentCount \t title

VIDEO_IDS="$1"
API_KEY="${YOUTUBE_API_KEY}"

if [ -z "$API_KEY" ]; then
  echo "ERROR: YOUTUBE_API_KEY not set" >&2
  exit 1
fi

if [ -z "$VIDEO_IDS" ]; then
  echo "ERROR: VIDEO_IDS is required" >&2
  exit 1
fi

python3 - "$VIDEO_IDS" "$API_KEY" << 'PYTHON'
import sys, json, urllib.request, urllib.error

video_ids = sys.argv[1]
api_key = sys.argv[2]

id_list = [v.strip() for v in video_ids.split(",") if v.strip()]

for i in range(0, len(id_list), 50):
    batch = ",".join(id_list[i:i+50])
    url = (
        f"https://www.googleapis.com/youtube/v3/videos"
        f"?part=statistics,snippet&id={batch}&key={api_key}"
    )

    try:
        req = urllib.request.Request(url)
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        print(f"ERROR: HTTP {e.code}", file=sys.stderr)
        sys.exit(1)

    for item in data.get("items", []):
        vid = item["id"]
        stats = item.get("statistics", {})
        title = item["snippet"]["title"]
        views = stats.get("viewCount", "0")
        likes = stats.get("likeCount", "0")
        comments = stats.get("commentCount", "0")
        print(f"{vid}\t{views}\t{likes}\t{comments}\t{title}")
PYTHON

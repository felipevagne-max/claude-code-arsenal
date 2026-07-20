#!/bin/bash
# Fetch top comments from a YouTube video, ordered by relevance
# Usage: youtube_comments.sh VIDEO_ID [max_comments] [min_likes]
# Requires: YOUTUBE_API_KEY environment variable

VIDEO_ID="$1"
MAX_COMMENTS="${2:-75}"
MIN_LIKES="${3:-2}"
API_KEY="${YOUTUBE_API_KEY}"

if [ -z "$API_KEY" ]; then
  echo "ERROR: YOUTUBE_API_KEY not set" >&2
  exit 1
fi

if [ -z "$VIDEO_ID" ]; then
  echo "ERROR: VIDEO_ID is required" >&2
  exit 1
fi

python3 - "$VIDEO_ID" "$MAX_COMMENTS" "$MIN_LIKES" "$API_KEY" << 'PYTHON'
import sys, json, urllib.request, urllib.parse, urllib.error

video_id = sys.argv[1]
max_comments = int(sys.argv[2])
min_likes = int(sys.argv[3])
api_key = sys.argv[4]

comments = []
page_token = ""
per_page = 100

while len(comments) < max_comments:
    url = (
        f"https://www.googleapis.com/youtube/v3/commentThreads"
        f"?part=snippet&videoId={video_id}"
        f"&maxResults={per_page}&order=relevance&textFormat=plainText"
        f"&key={api_key}"
    )
    if page_token:
        url += f"&pageToken={page_token}"

    try:
        req = urllib.request.Request(url)
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        body = e.read().decode()
        try:
            err = json.loads(body)
            reason = err.get("error", {}).get("errors", [{}])[0].get("reason", "")
            if reason == "commentsDisabled":
                sys.exit(0)
        except:
            pass
        print(f"ERROR: HTTP {e.code} for video {video_id}", file=sys.stderr)
        sys.exit(0)

    for item in data.get("items", []):
        snippet = item["snippet"]["topLevelComment"]["snippet"]
        likes = snippet.get("likeCount", 0)
        if likes < min_likes:
            continue
        text = snippet["textDisplay"].replace("\n", " ").replace("\t", " ")
        author = snippet["authorDisplayName"]
        published = snippet["publishedAt"][:10]
        reply_count = item["snippet"].get("totalReplyCount", 0)
        comments.append((likes, f"{author}\t{likes}\t{reply_count}\t{published}\t{text}"))

    page_token = data.get("nextPageToken", "")
    if not page_token:
        break

comments.sort(key=lambda x: x[0], reverse=True)
for _, c in comments[:max_comments]:
    print(c)
PYTHON

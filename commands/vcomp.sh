#!/bin/bash

# 使い方:
#   ./vcomp.sh <入力動画> <出力動画(.mp4)>
# 例:
#   ./vcomp.sh input.mov output.mp4
# 依存関係:
#   ffmpeg

set -euo pipefail

if [ "$#" -ne 2 ]; then
    echo "Usage: $(basename "$0") <input_video> <output_video>"
    exit 1
fi

INPUT="$1"
OUTPUT="$2"

ffmpeg -i "$INPUT" \
       -vf "scale=1280:-2" \
       -c:v libx264 \
       -preset veryslow \
       -crf 20 \
       -pix_fmt yuv420p \
       -c:a aac \
       -b:a 128k \
       -movflags +faststart \
       "$OUTPUT"
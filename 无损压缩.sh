#!/bin/bash

# 视频路径
VIDEO_PATH="$1"

# 输出图片名称
OUTPUT_NAME=${VIDEO_PATH%.*}

# ffmpeg -i "$VIDEO_PATH" -codec copy "$OUTPUT_NAME"_zip.mp4

# 无损压缩后的输出文件路径
output_file="$OUTPUT_NAME"_zip.mp4

# 使用x264进行无损压缩
# ffmpeg -i "$VIDEO_PATH" -c:v libx264 -qp 0 -preset ultrafast "$output_file"
# 使用x265进行无损压缩
# ffmpeg -i "$VIDEO_PATH" -c:v libx265 -x265-params lossless=1 "$output_file"
# 无损慢速压缩
ffmpeg -i "$VIDEO_PATH" -c:v libx264 -crf 18 -preset veryslow -c:a copy "$output_file"
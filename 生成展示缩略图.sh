#!/bin/bash

function generatePic () {
  # 视频路径
  VIDEO_PATH="$1"

  # 输出图片目录
  OUTPUT_DIR="frames"

  # 输出图片名称
  OUTPUT_NAME=${VIDEO_PATH%.*}

  # 九宫格布局
  GRID_LAYOUT="3x3"

  # 视频总时长
  DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$VIDEO_PATH")

  # 截取间隔
  INTERVAL=$(bc -l <<< "$DURATION/9")

  # 创建输出目录
  mkdir -p "$OUTPUT_DIR"

  # 循环截取
  for i in {0..9}
  do
    # 计算截取时间点
    TIME=$(bc -l <<< "$INTERVAL*$i")

    # 截取图片
    ffmpeg -ss "$TIME" -i "$VIDEO_PATH" -vframes 1 "$OUTPUT_DIR/$(printf "%03d" $i).jpg"
  done

  # 拼接图片
  montage -geometry +0+0 -tile "$GRID_LAYOUT" "$OUTPUT_DIR/*.jpg" "$OUTPUT_NAME.jpg"
  rm -r frames
}


if [ -z "$1" ]; then
  for file in ./*.mp4
  do
      echo "处理文件: $file"
      generatePic $file
  done
else
  for file in "$1"/*.mp4
  do
      echo "处理文件: $file"
  done
fi
# generatePic $1
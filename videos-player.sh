#!/bin/bash

VIDEO_DIR=/home/ubuntu/video # Define directory for the videos

while true; do
    for video in "$VIDEO_DIR"/*.mp4; do
        if [ -f "$video" ]; then
            cvlc --no-video-title-show --play-and-exit "$video"
        fi
    done
done

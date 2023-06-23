#!/bin/bash

process_file() {
    # get the video bitrate using ffprobe
    bitrate=$(ffprobe -v error -select_streams v:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "$1")

    # if bitrate is N/A or empty, calculate it manually
    if [ "$bitrate" == "N/A" ] || [ -z "$bitrate" ]; then
        filesize=$(ls -l "$1" | awk '{print $5}')
        duration=$(ffprobe -v error -select_streams v:0 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$1")
        bitrate=$(echo "scale=2; $filesize * 8 / $duration / 1000" | bc)
    else
        # convert bit rate to kbps
        bitrate=$(echo "scale=2; $bitrate / 1000" | bc)
    fi

    echo "$1 Video Bitrate: $bitrate kbps"
}

# export the function so it can be used in subprocesses
export -f process_file

# check if the input is a file or directory
if [ -f "$1" ]; then
    process_file "$1"
elif [ -d "$1" ]; then
    find "$1" -type f -exec bash -c 'file -i "$0" | grep -q video' {} \; -exec bash -c 'process_file "$0"' {} \;
else
    echo "Input is not a valid file or directory."
fi

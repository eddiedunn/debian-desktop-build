#!/bin/bash

# Function to process a single video file
process_video() {
    local original_video="$1"

    # Temporary output file
    local output_video="output.mp4"

    # delete output file if it exists
    if [ -f $output_video ]; then
        rm $output_video
    fi
    
    # Perform the conversion
    ffmpeg -nostdin -i "$original_video" -c:v h264_nvenc -b:v "$bitrate" "$output_video"

    # Check if ffmpeg command was successful
    if [ $? -eq 0 ]; then
        # Delete the original video file
        rm "$original_video"
        # Rename the output video file to the original file name
        mv "$output_video" "$original_video"
    else
        echo "There was a problem with the conversion for file: $original_video"
    fi
}

# Check if filename or directory argument is provided
if [ -z "$1" ]; then
    echo "Please provide a filename or directory as an argument."
    exit 1
fi

# Set the filename or directory
target="$1"

# Set the optional bitrate argument, default to 1100 kbps
bitrate="${2:-1100k}"

# Check if the target is a directory
if [ -d "$target" ]; then
    # Process video files recursively within the directory
    find "$target" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" -o -iname "*.mov" \) -print0 | while IFS= read -r -d '' file; do
        process_video "$file"
    done
else
    # Process a single video file
    process_video "$target"
fi

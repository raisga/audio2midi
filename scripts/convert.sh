#!/bin/bash

_convertMp3toMidi() {
    verbose_mode=$1
    input_dir=$2
    output_dir=$3
    if [ "$verbose_mode" = true ]; then
        echo ">> Converting MP3 to MIDI... ⏳"
    fi
    mkdir -p ./${output_dir}/midi
    basic-pitch "$output_dir" "$input_dir/op1/bass.mp3"
}
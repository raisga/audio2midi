#!/bin/bash

_convertMp3toMidi() {
    verbose_mode=$1
    input_dir=$2
    output_dir=$3
    $instruments=$4
    if [ "$verbose_mode" = true ]; then
        echo ">> Converting MP3 to MIDI... ⏳"
    fi
    mkdir -p ./${output_dir}/midi

    # Iterate over the array and create filenames based on its elements
    for instrument in "${instruments[@]}"; do
        # Create a filename based on the instrument name
        # filename="${instrument}.txt"
        # echo "Creating $filename"
        basic-pitch "$output_dir/midi" "$input_dir/op1/$instrument.mp3"
    done

}

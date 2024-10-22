#!/bin/bash

# Convert MP3 audio files to MIDI files
#
# Parameters:
#   verbose_mode (bool): A flag to indicate if the function should run in verbose mode
#   input_dir (str): The directory containing the input MP3 files
#   output_dir (str): The directory where the generated MIDI files will be stored
#   instruments (array): An array of instruments to convert to MIDI
#
# Description:
#   This function converts MP3 audio files to MIDI format. It creates a MIDI directory
#   in the output directory and converts each instrument specified in the 'instruments' array
#   to MIDI using the 'basic-pitch' command.
#
_convertMp3toMidi() {
    local verbose_mode=$1
    local input_dir=$2
    local output_dir=$3
    local $instruments=$4

    if [ "$verbose_mode" = true ]; then
        echo ">> Converting MP3 to MIDI... ⏳"
    fi
    mkdir -p ./${output_dir}/midi
    for instrument in "${instruments[@]}"; do
        basic-pitch "$output_dir/midi" "$input_dir/op1/$instrument.mp3"
    done
}
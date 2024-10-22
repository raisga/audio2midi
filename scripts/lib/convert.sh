#!/bin/bash

. ./scripts/constants.sh

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
    local complete_path=$2
    local selected_op=$4
    # local instruments=$5
    local name_suffix

    name_suffix="basic_pitch"
    if [ "$verbose_mode" = true ]; then
        echo ">> Converting MP3 to MIDI... ⏳"
    fi
    mkdir -p ./${complete_path}/${selected_op}/midi
    for instrument in "${INSTRUMENTS_TRACKS[@]}"; do
        basic-pitch ./${complete_path}/${selected_op}/midi ./${complete_path}/${selected_op}/${instrument}.mp3
        mv ./${complete_path}/${selected_op}/midi/${instrument}_${name_suffix}.mid ./${complete_path}/${selected_op}/${instrument}.mid
    done
    rm -rf ./${complete_path}/${selected_op}/midi
}
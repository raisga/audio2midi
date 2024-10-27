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
    local basic_pitch_suffix
    local no_prefix

    basic_pitch_suffix="_basic_pitch"
    no_prefix="no_"
    if [ "$verbose_mode" = true ]; then
        echo ">> Converting MP3 to MIDI... ⏳"
    fi
    mkdir -p ./${complete_path}/${selected_op}/midi
    for instrument in "${INSTRUMENTS_TRACKS[@]}"; do
        # Refactor: This check is for other operations op_full and op_extra, maybe no need to do this here? Or send a flag from argument or something like that
        if [ "./${complete_path}/${selected_op}/${no_prefix}${instrument}.mp3" ]; then
            basic-pitch ./${complete_path}/${selected_op}/midi ./${complete_path}/${selected_op}/${no_prefix}${instrument}.mp3
            mv ./${complete_path}/${selected_op}/midi/${no_prefix}${instrument}${basic_pitch_suffix}.mid ./${complete_path}/${selected_op}/${no_prefix}${instrument}.mid
        fi
        basic-pitch ./${complete_path}/${selected_op}/midi ./${complete_path}/${selected_op}/${instrument}.mp3
        mv ./${complete_path}/${selected_op}/midi/${instrument}${basic_pitch_suffix}.mid ./${complete_path}/${selected_op}/${instrument}.mid
    done
    rm -rf ./${complete_path}/${selected_op}/midi
}

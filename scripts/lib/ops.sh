#!/bin/bash

. ./scripts/constants.sh

# Perform the first operation: split all instruments from the audio file at once
#
# 1. Create the output directory if it doesn't exist
# 2. Split the instruments using `demucs`
# 3. Move the generated files to the output directory
# 4. Remove the temporary directory
#
# Parameters:
#   verbose_mode (bool): A flag to indicate if the function should run in verbose mode
#   model_name (str): The name of the model to use for the separation
#   complete_path (str): The complete path of the output directory
#   audio_file_path (str): The path of the audio file to separate
#   audio_file_name (str): The name of the audio file to separate
#   output_dir (str): The directory where the separated files will be stored
#
_op_mini() {
    local verbose_mode=$1
    local model_name=$2
    local complete_path=$3
    local audio_file_path=$4
    local audio_file_name=$5
    local output_dir=$6

    if [ "$verbose_mode" = true ]; then
        echo "> Using $OP_MINI operation to isolate instruments from the audio file"
    fi
    mkdir -p ./${complete_path}/${OP_MINI}
    demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir}
    mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/${OP_MINI}
    rm -rf ${output_dir}/${model_name}
}

# Perform the second operation: split instruments from the audio file one by one
#
# 1. Create the output directory if it doesn't exist
# 2. Split the instruments using `demucs` one by one
# 3. Move the generated files to the output directory
# 4. Remove the temporary directory
#
# Parameters:
#   verbose_mode (bool): A flag to indicate if the function should run in verbose mode
#   model_name (str): The name of the model to use for the separation
#   complete_path (str): The complete path of the output directory
#   audio_file_path (str): The path of the audio file to separate
#   audio_file_name (str): The name of the audio file to separate
#   output_dir (str): The directory where the separated files will be stored
#   instruments (array): An array of instruments to split from the audio file
#
_op_full() {
    local verbose_mode=$1
    local model_name=$2
    local complete_path=$3
    local audio_file_path=$4
    local audio_file_name=$5
    local output_dir=$6
    # local instruments=$7

    if [ "$verbose_mode" = true ]; then
        echo "> Using $OP_FULL operation to split all instruments with full variations from the audio file"
    fi
    mkdir -p ./${complete_path}/${OP_FULL}
    for instrument in "${INSTRUMENTS_TRACKS[@]}"; do
        demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems="$instrument"
    done
    mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/${OP_FULL}
    rm -rf ${output_dir}/${model_name}
}

# Perform the third operation: split instruments from the audio file with extra variations
#
# 1. Create the output directory if it doesn't exist
# 2. Split the instruments using `demucs` one by one with extra variations
# 3. Move the generated files to the output directory
# 4. Remove the temporary directory
#
# Parameters:
#   verbose_mode (bool): A flag to indicate if the function should run in verbose mode
#   model_name (str): The name of the model to use for the separation
#   complete_path (str): The complete path of the output directory
#   audio_file_path (str): The path of the audio file to separate
#   audio_file_name (str): The name of the audio file to separate
#   output_dir (str): The directory where the separated files will be stored
#   instruments (array): An array of instruments to split from the audio file
#
_op_extra() {
    local verbose_mode=$1
    local model_name=$2
    local complete_path=$3
    local audio_file_path=$4
    local audio_file_name=$5
    local output_dir=$6
    # local instruments=$7

    if [ "$verbose_mode" = true ]; then
        echo "> Using $OP_EXTRA operation to split all instruments with extra variations from the audio file"
    fi

    # # Create the output directory if it doesn't exist
    # mkdir -p ./${complete_path}/${OP_EXTRA}

    # # Split the instruments using `demucs` one by one
    # for instrument in "${INSTRUMENTS_TRACKS[@]}"; do
    #     # ...
    # done

    # # Move the generated files to the output directory
    # mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/${OP_EXTRA}

    # # Remove the temporary directory
    # rm -rf ${output_dir}/${model_name}
}
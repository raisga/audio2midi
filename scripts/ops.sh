#!/bin/bash

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
#   op1_dir (str): The name of the directory where the separated files will be stored
#
_op1() {
    local verbose_mode=$1
    local model_name=$2
    local complete_path=$3
    local audio_file_path=$4
    local audio_file_name=$5
    local output_dir=$6
    local op1_dir=$7

    if [ "$verbose_mode" = true ]; then
        echo "> op1 => first operation (done at once, split all instruments from the audio file)"
    fi
    mkdir -p ./${complete_path}/${op1_dir}
    demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir}
    mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/${op1_dir}
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
#   op2_dir (str): The name of the directory where the separated files will be stored
#
_op2() {
    local verbose_mode=$1
    local model_name=$2
    local complete_path=$3
    local audio_file_path=$4
    local audio_file_name=$5
    local output_dir=$6
    local op2_dir=$7
    local instruments=$8

    if [ "$verbose_mode" = true ]; then
        echo "> op2 => second operations (one by one, split instruments from the audio file)"
    fi
    mkdir -p ./${complete_path}/${op2_dir}
    for instrument in "${instruments[@]}"; do
        demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems="$instrument"
    done
    mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/${op2_dir}
    rm -rf ${output_dir}/${model_name}
}

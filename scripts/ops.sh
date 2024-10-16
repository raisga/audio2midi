#!/bin/bash

# Perform the first operation: split all instruments from the audio file at once
#
# 1. Create the output directory if it doesn't exist
# 2. Split the instruments using `demucs`
# 3. Move the generated files to the output directory
# 4. Remove the temporary directory
op1() {
    verbose_mode=$1
    model_name=$2
    complete_path=$3
    audio_file_path=$4
    audio_file_name=$5
    output_dir=$6

    if [ "$verbose_mode" = true ]; then
        echo "> op1 => first operation (done at once, split all instruments from the audio file)"
    fi
    mkdir -p ./${complete_path}/op1
    demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir}
    mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/op1
    rm -rf ${output_dir}/${model_name}
}

# Perform the second operation: split instruments from the audio file one by one
#
# 1. Create the output directory if it doesn't exist
# 2. Split the instruments using `demucs` one by one
# 3. Move the generated files to the output directory
# 4. Remove the temporary directory
op2() {
    verbose_mode=$1
    model_name=$2
    complete_path=$3
    audio_file_path=$4
    audio_file_name=$5
    output_dir=$6
    
    if [ "$verbose_mode" = true ]; then
        echo "> op2 => second operations (one by one, split instruments from the audio file)"
    fi
    mkdir -p ./${complete_path}/op2
    demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=bass
    demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=drums
    demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=other
    demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=vocals
    mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/op2
    rm -rf ${output_dir}/${model_name}
}

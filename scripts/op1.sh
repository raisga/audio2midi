#!/bin/sh

# opt1
# ---
echo "> opt1 => first operation (done at once, split all instruments from the audio file)"
mkdir -p ./${complete_path}/opt1
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir}
mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/opt1
rm -rf ${output_dir}/${model_name}

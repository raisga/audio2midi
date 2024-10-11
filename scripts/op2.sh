#!/bin/sh

echo "> opt2 => second operations (one by one, split instruments from the audio file)"
mkdir -p ./${complete_path}/opt2
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=bass
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=drums
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=other
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=vocals
mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/opt2
rm -rf ${output_dir}/${model_name}
#!/bin/sh

# ~~ Pipeline Idea ~~
# TODO: Support WAV files!
# TODO: Recreate script as a docker container

# Variables and Constants
selected_opt=''
total_opts=4
output_dir='separated'
model_name='htdemucs_ft'
audio_file_path="./gen/music_fx_an_ambiental_melodic_deathcore_song_with_odd.mp3"
audio_file_name=$(basename ${audio_file_path} | cut -f 1 -d '.')
complete_path="${output_dir}/${audio_file_name}"

# https://medium.com/@wujido20/handling-flags-in-bash-scripts-4b06b4d0ed04

# 0. Handle flags, replace variables values if needed
# (TODO: change from arguments flags, { --selected_opt, --total_opts, --model_name, --output_dir })

while getopts "hvf:" flag; do
  case $flag in
    \?) echo "Invalid option -$OPTARG" >&2; exit 1;;
    h) sh ./scripts/help.sh; exit 0;;
    v) sh ./scripts/version.sh; exit 0;;
    f) echo "Selected option: $OPTARG";;
  esac
done

sh ./scripts/dependencies.sh

echo ">> Split audio file operations... 🚀"
sh ./scripts/op1.sh
sh ./scripts/op2.sh

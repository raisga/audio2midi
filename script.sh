# ~~ Pipeline Idea ~~
# TODO: Support WAV files!
# TODO: Recreate script as a docker container

# ===================================================================================================================

# Variables and Constants
selected_opt=''
total_opts=4
output_dir='separated'
model_name='htdemucs_ft'
audio_file_path="./gen/music_fx_an_ambiental_melodic_deathcore_song_with_odd.mp3"
audio_file_name=$(basename ${audio_file_path} | cut -f 1 -d '.')
complete_path="${output_dir}/${audio_file_name}"

# ...................................................................................................................

# https://medium.com/@wujido20/handling-flags-in-bash-scripts-4b06b4d0ed04

# 0. Handle flags, replace variables values if needed
#  (TODO: change from arguments flags, { --selected_opt, --total_opts, --model_name, --output_dir })

# ...................................................................................................................

# 1. Installs dependencies if needed
echo ">> Installing dependencies if needed... ⏳"
brew list ffmpeg > /dev/null || brew install ffmpeg
brew list portaudio > /dev/null || brew install portaudio
brew list pipx > /dev/null || brew install pipx
pipx install demucs > /dev/null # TODO: check if demucs is install beforehand 
# ^
# NOTE: Alternatively we can use the API (if performance and price are worth it): https://splitter.ai/api 

# ...................................................................................................................

# 2. Split Audio Operations
echo ">> Split audio file operations... 🚀"

# opt1
# ---
echo "> opt1 => first operation (done at once, split all instruments from the audio file)"
mkdir -p ./${complete_path}/opt1
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir}
mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/opt1
rm -rf ${output_dir}/${model_name}

# opt2
# ---
echo "> opt2 => second operations (one by one, split instruments from the audio file)"
mkdir -p ./${complete_path}/opt2
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=bass
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=drums
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=other
demucs --name ${model_name} --mp3 ${audio_file_path} --out ${output_dir} --two-stems=vocals
mv ${output_dir}/${model_name}/${audio_file_name}/* ${complete_path}/opt2
rm -rf ${output_dir}/${model_name}

# ## opts_3 => Third operations (from each)

# ===================================================================================================================
# Compress mp3 files
# ffmpeg -i your_song.mp3 -codec:a libmp3lame -qscale:a 0 -map_metadata -1 -id3v2_version 3 -y your_song_compressed.mp3

# Convert wav/mp3? to midi
# audacity --export-midi output.mid input.wav

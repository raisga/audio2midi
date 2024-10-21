#!/bin/bash

# Installs dependencies if needed
#    - ffmpeg
#    - portaudio
#    - pipx
#    - demucs (via pipx)
_dependencies() {
    verbose_mode=$1
    if [ "$verbose_mode" = true ]; then
        echo ">> Installing dependencies if needed... ⏳"
    fi
    brew list ffmpeg > /dev/null || brew install ffmpeg
    brew list portaudio > /dev/null || brew install portaudio
    brew list pipx > /dev/null || brew install pipx
    pipx install demucs > /dev/null # TODO: check if demucs is installed beforehand 
    # ^ NOTE: Alternatively we can use the API (if performance and price are worth it): https://splitter.ai/api 
    pipx install 'basic-pitch[tf]' --force
}


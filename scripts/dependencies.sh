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
    # TODO: Add condition for macos m1/m2/m3 chips, installs with python3.10
    pipx install 'basic-pitch[tf]' --python 3.10 # --force 
    # ^ NOTE: Python 3.10 is forced installed with 'tf' -> tensorflow, because of M1/M2/M3? Chips used in MacBooks...
    # Use --force flag if there are issues to re-install
}


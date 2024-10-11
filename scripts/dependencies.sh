#!/bin/sh

# 1. Installs dependencies if needed
echo ">> Installing dependencies if needed... ⏳"
brew list ffmpeg > /dev/null || brew install ffmpeg
brew list portaudio > /dev/null || brew install portaudio
brew list pipx > /dev/null || brew install pipx
pipx install demucs > /dev/null # TODO: check if demucs is install beforehand 
# ^
# NOTE: Alternatively we can use the API (if performance and price are worth it): https://splitter.ai/api 

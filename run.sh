#!/bin/bash

# ~~ Pipeline Idea ~~
# TODO: Implement op_extra
# TODO: Add support for other audio formats than MP3 (WAV, FLAC, ...)?
# TODO: Add support for more models from demucs (htdemucs, ...)
# TODO: Add support for config basic-pitch
# TODO: Recreate script maybe as a python script?
# TODO: Add more options:
#   -c, --compress                           Compress the output file
#   -t, --tracks {bass,drums,vocals,other}   Select extract tracks from the output file
#   -l, --log                                Save a log file in the output directory

. ./scripts/main.sh

_main "$@"

#!/bin/bash

# ~~ Pipeline Idea ~~
# TODO: Support WAV files!
# TODO: Recreate script maybe as a docker container, python script?
# TODO: Add more options

#   -c, --compress                                  Compress the output file
#   -t, --tracks {bass,guitar,drums,vocals,other}   Select extract tracks from the output file
#   -l, --log                                       Save a log file in the output directory
# ...
#   -d, --daw                                       Creates a digital audio workstation (DAW) file {reaper, audacity}
#   -x, --fx                                        Add effects to the output file (implemented with PedalBoard)

. ./scripts/main.sh

_main "$@"

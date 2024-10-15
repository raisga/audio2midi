#!/bin/bash

# ~~ Pipeline Idea ~~
# TODO: Support WAV files!
# TODO: Recreate script maybe as a docker container, python script?

# Functions
. ./scripts/dependencies.sh
. ./scripts/usage.sh
. ./scripts/utils.sh
. ./scripts/ops.sh

# Default variables values and constants
verbose_mode=true
input_file=''
selected_opt=''
total_opts=4
output_dir='separated'
model_name='htdemucs_ft'

# Function to handle options and arguments
# Handle script options and arguments
# 
# The function processes the command line options and arguments and
# updates the relevant variables accordingly.
# 
# Parameters:
#   $@ - Command line options and arguments
# 
# Options:
#   -h, --help      Display script usage and exit
#   -q, --quiet     Disable verbose mode, only errors will be displayed in the script
#   -f, --file      Specify an input audio file to process

handle_options() {
  while [ $# -gt 0 ]; do
    case $1 in
      -h | --help)
        usage
        exit 0
        ;;
      -q | --quiet)
        verbose_mode=false
        ;;
      -f | --file*)
        if ! has_argument $@; then
          echo "File not specified." >&2
          usage
          exit 1
        fi
        input_file=$(extract_argument $@)
        shift
        ;;
      *)
        echo "Invalid option: $1" >&2
        usage
        exit 1
        ;;
    esac
    shift
  done
}

# Main script execution
handle_options "$@"

if [ -n "$input_file" ]; then
  echo "Output file specified: $input_file"
  audio_file_name=$(basename ${input_file} | cut -f 1 -d '.')
  complete_path="${output_dir}/${audio_file_name}"

  dependencies $verbose_mode

  echo ">> Split audio file operations... 🚀"
  op1 $verbose_mode
  op2 $verbose_mode
fi

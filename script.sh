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
compress_mode=false
input_file=''
selected_op=''
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
  local option
  local argument
  local index

  index=0
  while [ $# -gt 0 ]; do
    option="$1"
    argument="$2"

    # TODO: Implement compress_mode flag
    case $option in
      -h | --help)
        usage
        exit 0
        ;;
      -q | --quiet)
        verbose_mode=false
        ;;
      -f | --file)
        if [ -z "$argument" ]; then
          echo "ERROR: File not specified" >&2
          usage
          exit 1
        fi
        input_file="$argument"
        shift
        ;;
      -i | --install)
        dependencies "$verbose_mode"
        exit 0
        ;;
      -o | --output)
        if [ -z "$argument" ]; then
          echo "ERROR: Output directory not specified" >&2
          usage
          exit 1
        fi
        output_dir="$argument"
        shift
        ;;
      -m | --model)
        if [ -z "$argument" ]; then
          echo "ERROR: Model name not specified" >&2
          usage
          exit 1
        fi
        model_name="$argument"
        shift
        ;;
      -s | --select)
        if [ -z "$argument" ]; then
          echo "ERROR: Operation not specified" >&2
          usage
          exit 1
        fi
        selected_op="$argument"
        shift
        ;;
      *)
        echo "ERROR: Invalid option: $option" >&2
        usage
        exit 1
        ;;
    esac
    shift
    index=$((index + 1))
  done
}

# Main script execution
handle_options "$@"

if [ -n "$input_file" ]; then
  audio_file_name=$(basename ${input_file} | cut -f 1 -d '.')
  complete_path="${output_dir}/${audio_file_name}"

  if [ "$verbose_mode" = true ]; then
    echo "- Input file: $input_file"
    echo "- Output directory: $output_dir"  
    echo "- Model name: $model_name"
    echo "- Selected operation: $selected_op"
    echo ">> Starting split audio file operations... 🚀"
  fi

  op1 "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir"
  op2 "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir"
fi

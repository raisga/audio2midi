#!/bin/bash

# ~~ Pipeline Idea ~~
# TODO: Support WAV files!
# TODO: Recreate script maybe as a docker container, python script?

# Functions
. ./scripts/constants.sh
. ./scripts/dependencies.sh
. ./scripts/usage.sh
. ./scripts/utils.sh
. ./scripts/ops.sh
. ./scripts/convert.sh

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
#   -i, --install   Install dependencies
#   -o, --output    Specify an output directory
#   -m, --model     Specify a model name
#   -s, --select    Select an operation

# TODO: Add more options
#   -c, --compress  Compress the output file
#   -d, --daw       Play the output file
#   -t, --tracks    Select extract tracks from the output file
#   -x, --fx        Add effects to the output file

_handle_options() {
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
        _usage
        exit 0
        ;;
      -q | --quiet)
        verbose_mode=false
        ;;
      -f | --file)
        if [ -z "$argument" ]; then
          echo "ERROR: File not specified" >&2
          _usage
          exit "$RETURN_CODE_ERROR"
        fi
        input_file="$argument"
        shift
        ;;
      -i | --install)
        _dependencies "$verbose_mode"
        ;;
      -o | --output)
        if [ -z "$argument" ]; then
          echo "ERROR: Output directory not specified" >&2
          _usage
          exit "$RETURN_CODE_SUCCESS"
        fi
        output_dir="$argument"
        shift
        ;;
      -m | --model)
        if [ -z "$argument" ]; then
          echo "ERROR: Model name not specified" >&2
          _usage
          exit "$RETURN_CODE_ERROR"
        fi
        model_name="$argument"
        shift
        ;;
      -s | --select)
        if [ -z "$argument" ]; then
          echo "ERROR: Operation not specified" >&2
          _usage
          exit "$RETURN_CODE_ERROR"
        fi
        selected_op="$argument"
        shift
        ;;
      # TODO: Implement -d | --daw for export with reaper, and other softwares 
      *)
        echo "ERROR: Invalid option: $option" >&2
        _usage
        exit "$RETURN_CODE_ERROR"
        ;;
    esac
    shift
    index=$((index + 1))
  done
}

# Main script execution
_handle_options "$@"

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

  _op1 "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir"
  _op2 "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir"
  _convertMp3toMidi "$verbose_mode" "$complete_path" "$output_dir" "$instruments"
fi

#!/bin/bash

# ~~ Pipeline Idea ~~
# TODO: Support WAV files!
# TODO: Recreate script maybe as a docker container, python script?

# Functions
. ./scripts/variables.sh
. ./scripts/utils.sh
. ./scripts/dependencies.sh
. ./scripts/ops.sh
. ./scripts/convert.sh

# Function to handle options and arguments
# Handle script options and arguments
#
# The function processes the command line options and arguments and
# updates the relevant variables accordingly.
#
# Parameters:
#   $@: Command line options and arguments
#
_handle_options() {
    local option
    local argument
    local index=0

    while [ $# -gt 0 ]; do
        option="$1"
        argument="$2"

        # TODO: Add more options
        #   -c, --compress                                  Compress the output file
        #   -t, --tracks {bass,guitar,drums,vocals,other}   Select extract tracks from the output file
        #   -l, --log                                       Save a log file in the output directory
        # ...
        #   -d, --daw                                       Creates a digital audio workstation (DAW) file {reaper, audacity}
        #   -x, --fx                                        Add effects to the output file < with PedalBoard
        case $option in
        -h | --help)
            _print_usage
            exit "$RETURN_CODE_SUCCESS"
            ;;
        -q | --quiet)
            verbose_mode=false
            ;;
        -i | --install)
            _install_dependencies "$verbose_mode"
            ;;
        -f | --file)
            _check_argument_or_exit "$argument" "ERROR: File not specified"
            input_file="$argument"
            shift
            ;;
        -o | --outdir)
            _check_argument_or_exit "$argument" "ERROR: Output directory not specified"
            output_dir="$argument"
            shift
            ;;
        -m | --model)
            _check_argument_or_exit "$argument" "ERROR: Model name not specified"
            model_name="$argument"
            shift
            ;;
        -s | --select)
            _check_argument_or_exit "$argument" "ERROR: Operation not specified"
            selected_op="$argument"
            shift
            ;;
        *)
            echo "ERROR: Invalid option: $option" >&2
            _print_usage
            exit "$RETURN_CODE_ERROR"
            ;;
        esac
        shift
        index=$((index + 1))
    done
}

# Main function to execute the script.
#
# This function handles the command line options and arguments, and executes
# the audio processing operations based on the provided input file and options.
# It performs operations to split audio files and convert them to MIDI format.
#
# Parameters:
#   $@: Command line options and arguments
#
# Behavior:
#   - Parses and handles script options and arguments.
#   - Checks for the presence of an input file.
#   - Logs the input file, output directory, model name, and selected operation in verbose mode.
#   - Executes operations to split instruments from the audio file and convert them to MIDI.
#   - Displays usage information if no input file is provided.
#
_main() {
    _handle_options "$@"
    if [ -n "$input_file" ]; then
        local audio_file_name=$(basename ${input_file} | cut -f 1 -d '.')
        local complete_path="${output_dir}/${audio_file_name}"

        if [ "$verbose_mode" = true ]; then
            echo "- Input file: $input_file"
            echo "- Output directory: $output_dir"
            echo "- Model name: $model_name"
            echo "- Selected operation: $selected_op"
            echo ">> Starting split audio file operations... 🚀"
        fi
        _op1 "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir" "$op1_dir"
        _op2 "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir" "$op2_dir" "$instruments"
        _convertMp3toMidi "$verbose_mode" "$complete_path" "$output_dir" "$instruments"
    else
        _print_usage
        exit "$RETURN_CODE_ERROR"
    fi
}

_main "$@"

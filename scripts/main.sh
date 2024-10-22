#!/bin/bash

# Imports
. ./scripts/lib/dependencies.sh
. ./scripts/lib/ops.sh
. ./scripts/lib/convert.sh
. ./scripts/utils/helpers.sh
. ./scripts/utils/flags.sh

#The function processes the command line options and arguments and
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

        case $option in
        -h | --help)
            _print_usage
            exit "$RETURN_CODE_SUCCESS"
            ;;
        -v | --verbose)
            verbose_mode=true
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
        local audio_file_name
        local complete_path

        audio_file_name=$(basename ${input_file} | cut -f 1 -d '.')
        complete_path="$output_dir/$audio_file_name"
        if [ "$verbose_mode" = true ]; then
            echo "- Input file: $input_file"
            echo "- Output directory: $output_dir"
            echo "- Model name: $model_name"
            echo "- Selected operation: $selected_op"
            echo ">> Starting split audio file operations... 🚀"
        fi
        if [ "$selected_op" = "$OP_MINI" ]; then
            _op_mini "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir"
        elif [ "$selected_op" = "$OP_FULL" ]; then
            _op_full "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir" "$instruments"
        elif [ "$selected_op" = "$OP_EXTRA" ]; then
            _op_extra "$verbose_mode" "$model_name" "$complete_path" "$input_file" "$audio_file_name" "$output_dir" "$instruments"
        fi
        _convertMp3toMidi "$verbose_mode" "$complete_path" "$output_dir" "$selected_op" "$instruments"
    else
        _print_usage
        exit "$RETURN_CODE_SUCCESS"
    fi
}

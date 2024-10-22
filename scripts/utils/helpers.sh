#!/bin/bash

. ./scripts/constants.sh

# Check if an option has an argument
#
# Parameters:
#   $1 (string): The option with its argument (e.g. -f file.txt)
#   $2 (string): The default value to return if the option is given without an
#     argument
#
# Returns:
#   boolean: true if the option has an argument, false otherwise
_has_argument() {
    [[ ("$1" == *=* && -n ${1#*=}) || (! -z "$2" && "$2" != -*) ]]
}

# Extract the argument from an option
#
# If the option is given with an argument (e.g. -f file.txt), the argument is
# extracted and returned. If the argument is given without an argument (e.g. -f),
# the value of the second argument passed to this function is returned as the
# default value.
#
# Parameters:
#   $1 (string): The option with its argument (e.g. -f file.txt)
#   $2 (string): The default value to return if the option is given without an
#     argument
#
# Returns:
#   string: The extracted argument or default value
#
_extract_argument() {
    echo "${2:-${1#*=}}"
}

# Display script usage
# Prints the script usage to the standard output.
#
_print_usage() {
    echo "Usage: $0 -f {FILE} [OPTIONS]"
    echo "Options:"
    echo " -h, --help                                   Display script usage and exit"
    echo " -v, --verbose                                Enables verbose mode, errors will be displayed too"
    echo " -f, --file {FILE}                            Specify an input audio file to process"
    echo " -i, --install                                Install dependencies, includes: {mac_arm64}"
    echo " -o, --outdir {DIR}                           Specify an output directory (default: ./separated)"
    echo " -m, --model {htdemucs_ft}                    Specify a model name (default: htdemucs_ft)"
    echo " -s, --select {op_mini | op_full | op_extra}  Select an operation to perform (default: op_mini)"
}

# Check if an argument is given and exit if not
#
# Parameters:
#   $1 (string): The argument to check
#   $2 (string): The error message to display if the argument is empty
#
_check_argument_or_exit() {
    local argument=$1
    local message=$2

    if [ -z "$argument" ]; then
        echo $message >&2
        _print_usage
        exit "$RETURN_CODE_ERROR"
    fi
}

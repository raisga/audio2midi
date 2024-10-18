#!/bin/bash

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
    [[ ("$1" == *=* && -n ${1#*=}) || ( ! -z "$2" && "$2" != -*)  ]];
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
_extract_argument() {
    echo "${2:-${1#*=}}"
}

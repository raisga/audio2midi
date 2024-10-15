#!/bin/bash

version="0.0.1"
author="jraleman"
license="MIT"

# Display script usage
# Prints the script usage to the standard output.
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo " -h, --help      Display this help message"
    echo " -s, --silence   Disable verbose mode"
    echo " -f, --file      FILE Specify an input file"
}

# Display version information
# Prints version information to the standard output, including the script version, author, and license.
version() {
    version_msg="
    Version: ${version}
    Author: ${author}
    License: ${license}
    "
    echo $"$version_msg"
}

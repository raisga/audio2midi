#!/bin/bash

# Installs the necessary dependencies for the macOS ARM64 platform.
#
# Parameters:
#   verbose_mode (bool): A flag to indicate if the function should run in verbose mode
#
# Description:
#   This function installs the necessary dependencies for the macOS ARM64 platform,
#   which includes ffmpeg, portaudio, and pipx. It also installs demucs and
#   basic-pitch using pipx, which includes tensorflow.
#
_mac_arm64_dependencies() {
    local verbose_mode=$1

    if [ "$verbose_mode" = true ]; then
        echo ">> Installing dependencies if needed... ⏳"
    fi
    brew list ffmpeg >/dev/null || brew install ffmpeg
    brew list portaudio >/dev/null || brew install portaudio
    brew list pipx >/dev/null || brew install pipx
    pipx install demucs >/dev/null # TODO: check if demucs is installed beforehand
    # ^ NOTE: Alternatively we can use the API (if performance and price are worth it): https://splitter.ai/api
    # TODO: Add condition for macos m1/m2/m3 chips, installs with python3.10
    pipx install 'basic-pitch[tf]' --python 3.10 # --force
    # ^ NOTE: Python 3.10 is forced installed with 'tf' -> tensorflow, because of M1/M2/M3? Chips used in MacBooks...
    # Use --force flag if there are issues to re-install
}

# Installs platform-specific dependencies based on the architecture.
#
# Parameters:
#   verbose_mode (bool): A flag to indicate if the function should run in verbose mode
#
# Description:
#   This function checks the CPU architecture and installs the necessary
#   dependencies for the current platform. It is a wrapper around the
#   platform-specific dependencies functions.
#
_install_dependencies() {
    local verbose_mode=$1

    pc_arch=$(uname -m)
    # TODO: Check if also is Mac... This may install with Linux using arm64 architecture too!
    if [ "$pc_arch" = "arm64" ]; then
        _mac_arm64_dependencies "$verbose_mode"
    fi
}

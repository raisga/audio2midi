#!/bin/bash

. ./scripts/constants.sh

# Default variables values
input_file=""
verbose_mode=$DEFAULT_VERBOSE_MODE
compress_mode=$DEFAULT_COMPRESS_MODE
selected_op="$DEFAULT_SELECTED_OP"
output_dir="$DEFAULT_OUTPUT_DIR"
model_name="$DEFAULT_MODEL_NAME"
instruments=$INSTRUMENTS_TRACKS

#!/bin/bash

# Return codes
RETURN_CODE_SUCCESS=0
RETURN_CODE_ERROR=1

# Constants
OP_MINI="op_mini"
OP_FULL="op_full"
OP_EXTRA="op_extra"
HTDEMUCS_FT="htdemucs_ft"
OUTPUT="output"
declare -a INSTRUMENTS_TRACKS
INSTRUMENTS_TRACKS=("bass" "drums" "other" "vocals")

# Default variables values
DEFAULT_VERBOSE_MODE=false
DEFAULT_COMPRESS_MODE=false
DEFAULT_OUTPUT_DIR="$OUTPUT"
DEFAULT_MODEL_NAME="$HTDEMUCS_FT"
DEFAULT_SELECTED_OP="$OP_MINI"

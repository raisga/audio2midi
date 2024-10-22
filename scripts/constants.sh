#!/bin/bash

# Constants
RETURN_CODE_SUCCESS=0
RETURN_CODE_ERROR=1

# Default variables values and constants
verbose_mode=true
compress_mode=false
input_file=''
selected_op=''
output_dir='separated'
model_name='htdemucs_ft'
instruments=("bass" "vocals" "guitars" "drums" "other")

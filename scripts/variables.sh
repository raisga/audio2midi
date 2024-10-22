#!/bin/bash

# Constants
RETURN_CODE_SUCCESS=0
RETURN_CODE_ERROR=1

# Default variables values
verbose_mode=true
compress_mode=false
input_file=''
selected_ops=("op1" "op2")
op1_dir='op1'
op2_dir='op2'
output_dir='separated'
model_name='htdemucs_ft'
instruments=("bass" "drums" "other" "vocals")

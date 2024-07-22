#!/bin/bash

# This script is used to run the egglog program

# Set the path to the egglog program
EGGLOG="/Users/aziz/dev/lib/egglog/target/debug/egglog"
INPUTS=("$@")

$EGGLOG ${INPUTS[@]}

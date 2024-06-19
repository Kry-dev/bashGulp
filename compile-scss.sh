#!/bin/bash

# Check if sass is installed
if ! command -v sass &> /dev/null; then
    echo "sass command could not be found. Please install sass."
    exit 1
fi

# Define input and output directories
INPUT_DIR="src/scss"
OUTPUT_DIR="dist/css"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Find all SCSS files in the input directory and compile them into the output directory
find "$INPUT_DIR" -name "*.scss" -not -name "_*.scss" | while read -r FILE; do
  OUTPUT_FILE="$OUTPUT_DIR/$(basename "${FILE%.scss}.css")"
  sass "$FILE" "$OUTPUT_FILE"
done

#!/bin/bash

# Set the feroxbuster command with default options
feroxbuster_cmd="feroxbuster -n -t 1"

# Set the path to the wordlist file
wordlist="/usr/share/seclists/Discovery/Web-Content/common.txt"

# Set the output directory
output_dir="feroxbuster_results"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Check if a file argument was provided
if [ -z "$1" ]; then
  echo "Please provide a text file containing URLs as an argument."
  exit 1
fi

# Read the URLs from the input file
input_file="$1"
if [ ! -f "$input_file" ]; then
  echo "Input file '$input_file' does not exist."
  exit 1
fi

# Loop through each URL in the input file
while IFS= read -r url; do
  # Generate the output file name based on the URL
  filename=$(echo "$url" | sed 's/[^a-zA-Z0-9]/_/g')
  output_file="$output_dir/${filename}_results.txt"

  # Run feroxbuster with the specified options
  command="$feroxbuster_cmd -u $url -w $wordlist -o $output_file"
  echo "Running feroxbuster on $url..."
  eval "$command"
done < "$input_file"

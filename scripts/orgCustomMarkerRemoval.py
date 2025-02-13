#!/usr/bin/env python3

import re
import os
import sys

def replace_markers(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # Replace +<TextHere>+ with __<TextHere>__
    content = re.sub(r'\+(.+?)\+', r'_\1_', content)

    # Replace =<TextHere>= with *<TextHere>*
    #content = re.sub(r'=(.+?)=', r'*\1*', content)

    # Replace *<TextHere>* with **<TextHere>**
    #content = re.sub(r'\*(.+?)\*', r'**\1**', content)

    # Replace ~<TextHere>~ with `<TextHere>`
    #content = re.sub(r'~(.+?)~', r'`\1`', content)


    return content

def process_files(directory):
    # Iterate over all files in the specified directory
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            updated_content = replace_markers(file_path)

            # Write the updated content back to the original file
            with open(file_path, 'w') as file:
                file.write(updated_content)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 orgCustomMarkerRemoval.py <directory>")
        sys.exit(1)

    directory = sys.argv[1]

    if not os.path.isdir(directory):
        print(f"The specified path is not a directory: {directory}")
        sys.exit(1)

    process_files(directory)

#!/usr/bin/env python3

import re
import os
import sys

def replace_markers(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # Replace +<TextHere>+ with __<TextHere>__
    content = re.sub(r'\+(.+?)\+', r'__\1__', content)

    # Replace *<TextHere>* with **<TextHere>**
    content = re.sub(r'\*(.+?)\*', r'**\1**', content)

    # Replace ~<TextHere>~ with `<TextHere>`
    content = re.sub(r'~(.+?)~', r'`\1`', content)

    # Replace * at the beginning of the line for headers
    #content = re.sub(r'^\* (.+)', r'# \1', content, flags=re.MULTILINE)
    #content = re.sub(r'^\*\* (.+)', r'## \1', content, flags=re.MULTILINE)
    #content = re.sub(r'^\*\*\* (.+)', r'### \1', content, flags=re.MULTILINE)
    #content = re.sub(r'^\*\*\*\* (.+)', r'#### \1', content, flags=re.MULTILINE)
    #content = re.sub(r'^\*\*\*\*\* (.+)', r'##### \1', content, flags=re.MULTILINE)
    #content = re.sub(r'^\*\*\*\*\*\* (.+)', r'###### \1', content, flags=re.MULTILINE)

    # Replace =<TextHere>= with *<TextHere>*
    content = re.sub(r'=(.+?)=', r'*\1*', content)

    return content

def process_files(directory):
    # Find all .org files in the specified directory
    org_files = [f for f in os.listdir(directory) if f.endswith('.org')]

    for org_file in org_files:
        # Process each file
        file_path = os.path.join(directory, org_file)
        updated_content = replace_markers(file_path)

        # Write the updated content to a new .md file
        new_file_path = file_path.replace('.org', '.md')
        with open(new_file_path, 'w') as new_file:
            new_file.write(updated_content)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 convert_org_to_md.py <directory>")
        sys.exit(1)

    directory = sys.argv[1]

    if not os.path.isdir(directory):
        print(f"The specified path is not a directory: {directory}")
        sys.exit(1)

    process_files(directory)

#!/bin/bash

# Import extensions from the list in vscode-extensions.txt

EXTENSIONS_LIST="../vscode-extensions.txt"

# Check if the file with extensions exists
if [ ! -f "$EXTENSIONS_LIST" ]; then
    echo "$EXTENSIONS_LIST does not exist. Exiting."
    exit 1
fi

# Read the extensions from the list and install them
while IFS= read -r extension; do
    if [ -n "$extension" ]; then
        echo "Installing extension: $extension"
        code --install-extension "$extension"
    fi
done < "$EXTENSIONS_LIST"

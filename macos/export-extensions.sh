#!/bin/bash

# Path for the extensions list file in the root of the repo
EXTENSIONS_LIST="../../vscode-extensions.txt"

# Get the list of currently installed extensions
INSTALLED_EXTENSIONS=$(code --list-extensions)

# Write the list to the extensions file at the root of the repo
echo "$INSTALLED_EXTENSIONS" > "$EXTENSIONS_LIST"

# Ensure we're in the root directory of the repo
cd "$(dirname "$0")/.."

# Pull the latest version of the vscode-extensions.txt from the remote repository to compare
git fetch origin
git checkout origin/master -- "$EXTENSIONS_LIST"

# Compare the current extensions list with the one from the remote repository
ADDED_EXTENSIONS=$(comm -13 <(sort "$EXTENSIONS_LIST") <(sort "$EXTENSIONS_LIST"))
REMOVED_EXTENSIONS=$(comm -23 <(sort "$EXTENSIONS_LIST") <(sort "$EXTENSIONS_LIST"))

# Commit the changes (additions or removals)
if [ -n "$ADDED_EXTENSIONS" ]; then
    echo "Extensions added: $ADDED_EXTENSIONS"
    git add "$EXTENSIONS_LIST"
    git commit -m "Added extensions: $ADDED_EXTENSIONS"
fi

if [ -n "$REMOVED_EXTENSIONS" ]; then
    echo "Extensions removed: $REMOVED_EXTENSIONS"
    git add "$EXTENSIONS_LIST"
    git commit -m "Removed extensions: $REMOVED_EXTENSIONS"
fi

# Push the changes to the remote repository
git push origin master

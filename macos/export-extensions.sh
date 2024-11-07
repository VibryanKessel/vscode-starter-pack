#!/bin/bash

# Export the list of installed extensions in VSCode to a file
EXTENSIONS_LIST="../vscode-extensions.txt"

# Get a list of currently installed extensions
INSTALLED_EXTENSIONS=$(code --list-extensions)

# Write the list to the extensions file
echo "$INSTALLED_EXTENSIONS" > "$EXTENSIONS_LIST"

# Check for changes between current and previous extensions
if [ -f "previous-extensions.txt" ]; then
    # Compare the old and new extension lists
    ADDED_EXTENSIONS=$(comm -13 <(sort previous-extensions.txt) <(sort "$EXTENSIONS_LIST"))
    REMOVED_EXTENSIONS=$(comm -23 <(sort previous-extensions.txt) <(sort "$EXTENSIONS_LIST"))

    # Commit changes (additions or removals)
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
else
    echo "No previous extensions file found. Skipping comparison."
fi

# Push changes to the remote repository
git push origin master

# Update previous extensions file for future comparisons
cp "$EXTENSIONS_LIST" previous-extensions.txt

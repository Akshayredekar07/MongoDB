#!/bin/bash

# Create folders if they don't exist
mkdir -p notes_txt
mkdir -p notes_md

echo "Moving all .txt files to notes_txt/ ..."
find . -maxdepth 1 -iname "*.txt" -exec mv {} notes_txt/ \;

echo "Renaming and moving .md files to notes_md/ ..."
counter=1

for file in *.md; do
    # Skip if not a file
    [ -f "$file" ] || continue

    # Extract filename without extension
    base=$(basename "$file" .md)

    # If already in format like SXX.something.md, just move
    if [[ "$base" =~ ^S[0-9]+\. ]]; then
        mv "$file" notes_md/
        continue
    fi

    # Normalize the filename: lowercase, replace spaces with underscores
    normalized=$(echo "$base" | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g' | sed 's/&/and/g' | tr -cd '[:alnum:]_.')

    # Pad counter to 2 digits
    padded_num=$(printf "%02d" $counter)
    new_name="S${padded_num}.${normalized}.md"

    mv "$file" "notes_md/$new_name"
    echo "Renamed $file → notes_md/$new_name"

    ((counter++))
done

echo "✅ Organization complete!"

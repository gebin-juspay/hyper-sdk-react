#!/bin/bash

# Set locale to UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Check if the tenant ID is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <tenant_id>"
    exit 1
fi

# Assign arguments to variables
TENANT_ID=$1

# Generate the capitalized tenant ID
CAPITALIZED_TENANT_ID=$2

SDK_NAME=$3

# Confirm the replacements
echo "Replacing '_juspay' with '$TENANT_ID' and '_Juspay' with '$CAPITALIZED_TENANT_ID'... and sdk name is '$SDK_NAME'"

# Function to handle text replacement in files
process_files() {
    local extension="$1"
    echo "Processing *.$extension files..."
    find . -type d \( -name node_modules \) -prune -o -type f -name "*.$extension" -print | while IFS= read -r file; do
        if [ -f "$file" ]; then
            echo "Processing file: $file"
            # Convert file to UTF-8 if it's not already in UTF-8
            # encoding=$(file -bi "$file" | sed -e "s/^[^=]*=//")
            # if [ "$encoding" != "utf-8"]; then
            #     iconv -f "$encoding" -t UTF-8 "$file" -o "$file.utf8" 2>/dev/null
            #     if [ $? -eq 0 ]; then
            #         mv "$file.utf8" "$file"
            #     else
            #         echo "Failed to convert file encoding: $file $encoding"
            #         # continue
            #     fi
            # fi

            # Perform text replacements
            sed -i.bak "s/_juspay-payment-sdk-react/$SDK_NAME/g" "$file"
            sed -i.bak "s/_juspay/$TENANT_ID/g" "$file"
            sed -i.bak "s/_Juspay/$CAPITALIZED_TENANT_ID/g" "$file"

            # Clean up backup files created by sed
            rm "$file.bak"
        else
            echo "File '$file' does not exist or is not a regular file."
        fi
    done
}


echo "Renaming files starting with _Juspay..."
find . -type d \( -name node_modules \) -prune -o -type f -name '_Juspay*' -print | while IFS= read -r file; do
    if [ -f "$file" ]; then
        new_file=$(echo "$file" | sed "s/_Juspay/$CAPITALIZED_TENANT_ID/")
        if [ "$file" != "$new_file" ]; then
            echo "Renaming '$file' to '$new_file'"
            mv "$file" "$new_file"
        fi
    else
        echo "File '$file' does not exist or is not a regular file."
    fi
done


echo "Renaming files starting with _juspay-payment-sdk-react..."
find . -type d \( -name node_modules \) -prune -o -type f -name '_juspay-payment-sdk-react*' -print | while IFS= read -r file; do
    if [ -f "$file" ]; then
        new_file=$(echo "$file" | sed "s/_juspay-payment-sdk-react/$SDK_NAME/")
        if [ "$file" != "$new_file" ]; then
            echo "Renaming '$file' to '$new_file'"
            mv "$file" "$new_file"
        fi
    else
        echo "File '$file' does not exist or is not a regular file."
    fi
done

echo "Replacement and renaming complete."


# Process specific file types
for ext in mm m kt java js tsx h md podspec json podfilef; do
    process_files "$ext"
done

# Rename files starting with _Juspay to start with _tenant_id


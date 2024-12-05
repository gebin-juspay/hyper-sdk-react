#!/bin/bash

# Set locale to UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8



response=$(curl -s -w "%{http_code}" -o tenant-configs.json "https://hypersdk.juspay.in/sdk-config-server/tenant-configs.json")

# Check for curl errors
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to make the API request."
    exit 1
fi

# Check the HTTP response code
if [[ "$response" -ne 200 ]]; then
    echo "Error: Received HTTP response code $response."
    cat tenant-configs.json  # Optionally print the response body
    rm tenant-configs.json
    exit 1
fi

# Read the JSON data from the temporary file
response=$(<tenant-configs.json)

# Get a list of tenants (keys at the top level)
tenants=$(echo "$response" | jq -r 'keys[]')

get_absolute_path() {
    local relative_path="$1"

    if [ ! -d "$relative_path" ]; then
        echo "Gebin is in created path $relativ_path"
        mkdir "$relative_path"
    fi


    if command -v realpath &> /dev/null; then
        # Use realpath if available
        absolute_path=$(realpath "$relative_path")
    elif command -v readlink &> /dev/null; then
        # Fallback to readlink if realpath is not available
        absolute_path=$(readlink -f "$relative_path")
    else
        echo "Error: Neither 'realpath' nor 'readlink' is available."
        exit 1
    fi

    echo "$absolute_path"
}

HOME_PATH=$(get_absolute_path "../")
TEMPLATE_REPO_PATH=$(get_absolute_path "./")
last_commit_message=$(git log -1 --pretty=%B)

cd "$TEMPLATE_REPO_PATH"

echo "gebin is here $HOME_PATH"
echo "gebin is here ${HOME_PATH}/temp"

mkdir "$HOME_PATH/temp"
mkdir "$HOME_PATH/output"


# Loop through each tenant
for tenant in $tenants; do
    echo "Processing tenant: $tenant"payments
    rm -rf "$TEMPERORY_SDK_PATH/hyper-sdk-react"
    rm -rf "$TARGET_REPO_PATH/hyper-sdk-react"
    TENANT_ID=$tenant

    # Parse the JSON response using the tenant variable
    assetZipUrl_prod=$(echo "$response" | jq -r ".${tenant}.ios.assetZipUrl.prod")
    assetZipUrl_sandbox=$(echo "$response" | jq -r ".${tenant}.ios.assetZipUrl.sandbox")
    assetZipUrl_versioned=$(echo "$response" | jq -r ".${tenant}.ios.assetZipUrl.versioned")
    ios_sdkName=$(echo "$response" | jq -r ".${tenant}.ios.sdkName")
    ios_merchantConfigFile=$(echo "$response" | jq -r ".${tenant}.ios.merchantConfigFile")
    ios_releaseConfigUrl=$(echo "$response" | jq -r ".${tenant}.ios.releaseConfigUrl")

    android_sdkName=$(echo "$response" | jq -r ".${tenant}.android.sdkName")
    android_packageName=$(echo "$response" | jq -r ".${tenant}.android.packageName")
    android_pluginGroupId=$(echo "$response" | jq -r ".${tenant}.android.pluginGroupId")
    echo "gbin juspay plugin id $android_pluginGroupId"
    android_pluginName=$(echo "$response" | jq -r ".${tenant}.android.pluginName")
    android_pluginArtifactId=$(echo "$response" | jq -r ".${tenant}.android.pluginArtifactId")
    echo "gbin juspay art id $android_pluginArtifactId"
    android_releaseConfigUrl=$(echo "$response" | jq -r ".${tenant}.android.releaseConfigUrl")

    flutter_sdkName=$(echo "$response" | jq -r ".${tenant}.flutter.sdkName")
    flutter_package=$(echo "$response" | jq -r ".${tenant}.flutter.package")
    flutter_gitUrlRemote=$(echo "$response" | jq -r ".${tenant}.flutter.gitUrlRemote")

    react_sdkName=$(echo "$response" | jq -r ".${tenant}.react.sdkName")
    react_callbackEventName=$(echo "$response" | jq -r ".${tenant}.react.callbackEventName")
    react_gitUrlRemote=$(echo "$response" | jq -r ".${tenant}.react.gitUrlRemote")
    react_moduleName=$(echo "$response" | jq -r ".${tenant}.react.moduleName")
    react_merchantViewPrefix=$(echo "$response" | jq -r ".${tenant}.react.merchantViewPrefix")
    react_clientIdHolder=$(echo "$response" | jq -r ".${tenant}.react.clientIdHolder")


    defaultClientId=$(echo "$response" | jq -r ".${tenant}.defaultClientId")
    classNamePrefix=$(echo "$response" | jq -r ".${tenant}.classNamePrefix")
    tenantDomain=$(echo "$response" | jq -r ".${tenant}.tenantAssetsDomain")

    #!/bin/bash






    # Variables

    TEMPERORY_SDK_PATH=$(get_absolute_path "$HOME_PATH/temp/")  # Directory with contents to move
    TARGET_REPO_PATH=$(get_absolute_path "$HOME_PATH/output/")     # Directory to move contents to
    REMOTE_URL="git@github.com:gebin-juspay/$react_sdkName.git"



    echo "gebin home $HOME_PATH"
    echo "gebin TEMPLATE_REPO_PATH $TEMPLATE_REPO_PATH"
    echo "gebin TEMPERORY_SDK_PATH $TEMPERORY_SDK_PATH"
    echo "gebin TARGET_REPO_PATH $TARGET_REPO_PATH"
    echo "gebin REMOTE_URL $REMOTE_URL"
    echo "gebin home $HOME_PATH"
    cp -r "$TEMPLATE_REPO_PATH" "$TEMPERORY_SDK_PATH"
    cp -r "$TEMPLATE_REPO_PATH" "$TARGET_REPO_PATH"

    cd "$TARGET_REPO_PATH/hyper-sdk-react"
    git checkout -b $react_sdkName || git checkout $react_sdkName

    git rm -rf .
    git clean -fxd

    copy_contents() {
        if [ ! -d "$TEMPLATE_REPO_PATH" ]; then
            echo "Error: Source directory '$TEMPLATE_REPO_PATH' does not exist."
            exit 1
        fi

        if [ -d "$TEMPERORY_SDK_PATH" ]; then
            rm -rf "$TEMPERORY_SDK_PATH"
        fi

        echo "gebin $TEMPERORY_SDK_PATH"

        mkdir -p "$TEMPERORY_SDK_PATH"


        echo "Copying contents from '$TEMPLATE_REPO_PATH' to '$TEMPERORY_SDK_PATH'..."
        rsync -av --exclude-from='.rsyncignore' "$TEMPLATE_REPO_PATH/"* "$TEMPERORY_SDK_PATH/"
        # cp -r "$TEMPLATE_REPO_PATH/"* "$TEMPERORY_SDK_PATH/"

        # Optionally, handle hidden files and directories
        # rsync -av --exclude-from='.rsyncignore' "$TEMPLATE_REPO_PATH"/.* "$TEMPERORY_SDK_PATH/"
        # cp -r "$TEMPLATE_REPO_PATH"/.* "$TEMPERORY_SDK_PATH/" 2>/dev/null

        echo "Contents copied successfully."
    }



    # move_contents() {
    #     if [ ! -d "$SOURCE_DIR" ]; then
    #         echo "Error: Source directory '$SOURCE_DIR' does not exist."
    #         exit 1
    #     fi

    #     if [ ! -d "$TARGET_DIR" ]; then
    #         echo "Target directory '$TARGET_DIR' does not exist. Creating it..."
    #         mkdir -p "$TARGET_DIR"
    #     fi

    #     # Move contents from source to target directory
    #     echo "Moving contents from '$SOURCE_DIR' to '$TARGET_DIR'..."
    #     mv "$SOURCE_DIR"/* "$TARGET_DIR/"

    #     # Optionally, handle hidden files and directories
    #     mv "$SOURCE_DIR"/.* "$TARGET_DIR/" 2>/dev/null

    #     echo "Contents moved successfully."
    # }


    # Functions
    function check_repo_exists() {
        # Check if a repo exists at the given remote URL
        echo "Checking if the repository '$REMOTE_URL' exists..."
        if gh repo view "$react_sdkName" &>/dev/null; then
            echo "Repository '$REMOTE_URL' already exists."
            return 0
        else
            echo "Repository '$REMOTE_URL' does not exist."
            return 1
        fi
    }

    function create_repo() {
        # Create a new repository using GitHub CLI
        echo "Creating new repository '$react_sdkName'..."
        gh repo create "$react_sdkName" --public --confirm
    }

    function clone_repo() {
        echo "Cloning the existing repository from '$REMOTE_URL'..."
        cd "$HOME_PATH"
        mkdir "$react_sdkName"
        # git clone "$REMOTE_URL" "$TARGET_REPO_PATH"
        # git checkout main
    }


    # Functions

    function move_contents() {
        # Move contents from the current repo to the new repo directory
        echo "Moving contents from '$TEMPERORY_SDK_PATH' to '$TARGET_REPO_PATH'..."

        if [ ! -d "$TEMPERORY_SDK_PATH" ]; then
            echo "Error: Source directory '$TEMPERORY_SDK_PATH' does not exist."
            exit 1
        fi

        # if [ -d "$TARGET_REPO_PATH" ]; then
        #     rm -rf "$TARGET_REPO_PATH"
        # fi

        # echo "gebin $TARGET_REPO_PATH"

        # mkdir -p "$TARGET_REPO_PATH"


        echo "Copying contents from '$TEMPERORY_SDK_PATH' to '$TARGET_REPO_PATH'..."
        rsync -av "$TEMPERORY_SDK_PATH/"* "$TARGET_REPO_PATH/"
        # cp -r "$TEMPERORY_SDK_PATH/"* "$TARGET_REPO_PATH/"

        # Optionally, handle hidden files and directories
        # rsync -av "$TEMPERORY_SDK_PATH"/.* "$TARGET_REPO_PATH/"
        # cp -r "$TEMPLATE_REPO_PATH"/.* "$TARGET_REPO_PATH/" 2>/dev/null

        echo "Contents copied successfully."
    }

    function replace_contents() {
        # Remove all contents except the .git directory
        echo "Replacing contents in '$TARGET_REPO_PATH' with contents from '$TEMPERORY_SDK_PATH'..."
        find "$TARGET_REPO_PATH" -mindepth 1 ! -name '.git' -exec rm -rf {} +
        cp -r "$SOURCE_DIR/"* "$TARGET_REPO_PATH/"
    }

    function setup_and_push_repo() {
        # Initialize new Git repo, commit and push
        cd "$TARGET_REPO_PATH" || exit

        echo "Initializing a new Git repository in '$TARGET_REPO_PATH'..."
        git init

        echo "Adding files to the new repository..."
        git add .

        echo "Committing files..."
        git commit -m "Initial commit with contents moved from another directory"

        echo "Adding remote repository URL..."
        git remote add origin "$REMOTE_URL"

        echo "Pushing to the new remote repository..."
        git push -u -f origin master
    }


    function commit_and_push_changes() {
        cd "$TARGET_REPO_PATH/hyper-sdk-react" || exit
        if [ ! -d "./git" ]; then
            echo "Initializing a fresh repo"
            git init
        fi
        # Configure Git (adjust user details as needed)
        # git config user.name "Your Name"
        # git config user.email "your-email@example.com"

        echo "Adding files to the repository..."
        git add .

        echo "Committing changes..."
        git commit -m "$last_commit_message"

        echo "Pushing changes to the remote repository..."
        git push -f --set-upstream origin $react_sdkName
    }

    # rm -rf "./git"

    # copy_contents
    cd "$TEMPERORY_SDK_PATH/hyper-sdk-react"
    echo "gebin removing git"
    rm -rf ".git"

    echo "Replacing '_juspay' with '$TENANT_ID' and '_Juspay' with '$classNamePrefix'... and sdk name is '$react_sdkName'"

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

                sed -i.bak "s|https://public.releases.juspay.in|$tenantDomain|g" "$file"
                sed -i.bak "s/_JuspayHyperEvent/$react_callbackEventName/g" "$file"
                sed -i.bak "s/_JuspayHeader/${react_merchantViewPrefix}Header/g" "$file"
                sed -i.bak "s/_JuspayFooter/${react_merchantViewPrefix}Footer/g" "$file"
                sed -i.bak "s/juspayClientId/$react_clientIdHolder/g" "$file"
                # sed -i.bak "s/https://public.releases.juspay.in/$tenantDomain/g" "$file"
                sed -i.bak "s/_JuspayPayments/$classNamePrefix/g" "$file"
                sed -i.bak "s/_JuspaySDKReact/$react_moduleName/g" "$file"
                sed -i.bak "s/in._juspay_group_id/$android_pluginGroupId/g" "$file"
                sed -i.bak "s/in._juspay._juspaywrappersdk/$android_packageName/g" "$file"
                sed -i.bak "s/hypersdk.plugin/$android_pluginArtifactId/g" "$file"
                sed -i.bak "s/_juspaySdkPlugin/$android_pluginName/g" "$file"
                # sed -i.bak "s/_juspaywrappersdk/$android_sdkName/g" "$file"
                sed -i.bak "s/_juspay-payment-sdk-react/$react_sdkName/g" "$file"
                sed -i.bak "s/_juspay/$TENANT_ID/g" "$file"
                sed -i.bak "s/_JuspayPayment/$classNamePrefix/g" "$file"
                sed -i.bak "s/_Juspay/$classNamePrefix/g" "$file"

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
            new_file=$(echo "$file" | sed "s/_Juspay/$classNamePrefix/")
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
            new_file=$(echo "$file" | sed "s/_juspay-payment-sdk-react/$react_sdkName/")
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
    for ext in mm m kt java js tsx h md podspec json xml gradle podfilef; do
        process_files "$ext"
    done


    # Main script
    # check_repo_exists || create_repo
    # if [ -d "$TARGET_REPO_PATH" ]; then
    #     echo "The directory '$TARGET_REPO_PATH' already exists."
    #     rm -rf $TARGET_REPO_PATH
    # fi

    # clone_repo
    # move_contents
    # replace_contents
    cp -r "$TEMPERORY_SDK_PATH/hyper-sdk-react" "$TARGET_REPO_PATH"



    commit_and_push_changes

done


# Check if the tenant ID is provided
# if [ "$#" -ne 10 ]; then
#     echo "Usage: $0 <tenant_id>"
#     exit 1
# fi

# # Assign arguments to variables

# # Generate the capitalized tenant ID

# REACT_SDK_NAME=$9

# Confirm the replacements
# Rename files starting with _Juspay to start with _tenant_id




# echo "Repository setup and push completed."



# #!/bin/bash

# # Variables
# SOURCE_DIR="/path/to/source/contents"  # Directory with contents to move
# TARGET_REPO_PATH="/path/to/temp/repo"   # Temporary directory for cloning the repo

# # Functions


# function replace_contents() {
#     # Remove all contents except the .git directory
#     echo "Replacing contents in '$TARGET_REPO_PATH' with contents from '$SOURCE_DIR'..."
#     find "$TARGET_REPO_PATH" -mindepth 1 ! -name '.git' -exec rm -rf {} +
#     cp -r "$SOURCE_DIR/"* "$TARGET_REPO_PATH/"
# }


# cd "$TEMPLATE_SDK_PATH"
# echo "Replacing '_juspay' with '$TENANT_ID' and '_Juspay' with '$classNamePrefix'... and sdk name is '$react_sdkName'"

# # Function to handle text replacement in files
# process_files() {
#     local extension="$1"
#     echo "Processing *.$extension files..."
#     find . -type d \( -name node_modules \) -prune -o -type f -name "*.$extension" -print | while IFS= read -r file; do
#         if [ -f "$file" ]; then
#             echo "Processing file: $file"
#             # Convert file to UTF-8 if it's not already in UTF-8
#             # encoding=$(file -bi "$file" | sed -e "s/^[^=]*=//")
#             # if [ "$encoding" != "utf-8"]; then
#             #     iconv -f "$encoding" -t UTF-8 "$file" -o "$file.utf8" 2>/dev/null
#             #     if [ $? -eq 0 ]; then
#             #         mv "$file.utf8" "$file"
#             #     else
#             #         echo "Failed to convert file encoding: $file $encoding"
#             #         # continue
#             #     fi
#             # fi

#             # Perform text replacements
#             sed -i.bak "s/_juspay-payment-sdk-react/$react_sdkName/g" "$file"
#             sed -i.bak "s/_juspay/$TENANT_ID/g" "$file"
#             sed -i.bak "s/_Juspay/$classNamePrefix/g" "$file"

#             # Clean up backup files created by sed
#             rm "$file.bak"
#         else
#             echo "File '$file' does not exist or is not a regular file."
#         fi
#     done
# }


# echo "Renaming files starting with _Juspay..."
# find . -type d \( -name node_modules \) -prune -o -type f -name '_Juspay*' -print | while IFS= read -r file; do
#     if [ -f "$file" ]; then
#         new_file=$(echo "$file" | sed "s/_Juspay/$classNamePrefix/")
#         if [ "$file" != "$new_file" ]; then
#             echo "Renaming '$file' to '$new_file'"
#             mv "$file" "$new_file"
#         fi
#     else
#         echo "File '$file' does not exist or is not a regular file."
#     fi
# done


# echo "Renaming files starting with _juspay-payment-sdk-react..."
# find . -type d \( -name node_modules \) -prune -o -type f -name '_juspay-payment-sdk-react*' -print | while IFS= read -r file; do
#     if [ -f "$file" ]; then
#         new_file=$(echo "$file" | sed "s/_juspay-payment-sdk-react/$react_sdkName/")
#         if [ "$file" != "$new_file" ]; then
#             echo "Renaming '$file' to '$new_file'"
#             mv "$file" "$new_file"
#         fi
#     else
#         echo "File '$file' does not exist or is not a regular file."
#     fi
# done

# echo "Replacement and renaming complete."


# # Process specific file types
# for ext in mm m kt java js tsx h md podspec json podfilef; do
#     process_files "$ext"
# done





# # Main script
# if [ -d "$TARGET_REPO_PATH" ]; then
#     echo "The directory '$TARGET_REPO_PATH' already exists."
# else
#     clone_repo
# fi

# replace_contents
# commit_and_push_changes

# echo "Repository updated and changes pushed to '$REMOTE_URL'."
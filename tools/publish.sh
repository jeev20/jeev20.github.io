#!/bin/bash

# Check if the script is being run inside a Git repository
git rev-parse --is-inside-work-tree > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: This script must be run inside a Git repository."
    exit 1
fi

# Prompt the user for a commit message
read -p "Enter commit message: " commit_message

# Get the current date, time, and seconds
current_datetime=$(date +'%Y-%m-%d %H:%M:%S')

# Append the date, time, seconds, and an additional string to the commit message
commit_message="$commit_message - $current_datetime]"

# Check if the commit message is empty
if [ -z "$commit_message" ]; then
    echo "Error: Commit message cannot be empty."
    exit 1
fi

# Add all changes to the staging area
git add .

# Commit the changes with the updated message
git commit -m "$commit_message"

# Check if the commit was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to commit changes."
    exit 1
fi

# Fetch changes from the remote repository
git fetch origin

# Merge or rebase the changes
read -p "Do you want to merge (m) or rebase (r) the remote changes? " merge_or_rebase

if [ "$merge_or_rebase" == "m" ]; then
    git merge origin/main
elif [ "$merge_or_rebase" == "r" ]; then
    git rebase origin/main
else
    echo "Invalid option. Skipping merge/rebase."
fi

# Push the changes to the remote repository
git push origin main

# Check if the push was successful
if [ $? -eq 0 ]; then
    echo "Changes pushed to the remote repository successfully."
else
    echo "Error: Failed to push changes to the remote repository."
fi

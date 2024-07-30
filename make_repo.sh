#!/bin/bash

# Check if gh CLI is installed
if ! command -v gh &> /dev/null
then
    echo "gh CLI is required but not installed. Please install it first."
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git is required but not installed. Please install it first."
    exit 1
fi

# Check if the user provided a repository name
if [ -z "$1" ]
then
    echo "Usage: $0 <repo-name>"
    exit 1
fi

REPO_NAME=$1

# Create a new private repository on GitHub
echo "Creating GitHub repository '$REPO_NAME'..."
gh repo create "$REPO_NAME" --private --confirm

# Initialize git in the current directory
echo "Initializing git repository..."
git init

# Add the remote origin
echo "Adding remote origin..."
git remote add origin "git@github.com:$(gh auth status --show-token | grep -oP '(?<=Logged in to github.com as ).*(?= \[)' )/$REPO_NAME.git"

# Add the current content of the directory
echo "Adding current directory contents to git..."
git add .

# Commit the changes
echo "Committing changes..."
git commit -m "Initial commit"

# Push to origin master
echo "Pushing to origin master..."
git push -u origin master

echo "Repository '$REPO_NAME' created and pushed to GitHub successfully."

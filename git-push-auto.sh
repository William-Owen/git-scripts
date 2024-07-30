#!/bin/sh

# Check if the current branch has an upstream branch set
if ! git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
    # Get the current branch name
    current_branch=$(git branch --show-current)
    
    # Push to origin and set upstream
    git push --set-upstream origin "$current_branch"
else
    # Upstream is already set, just push
    git push
fi

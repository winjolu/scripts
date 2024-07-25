#!/bin/bash

# Directory where you want to clone the repositories
cd /Users/Winston/Documents/github

# Read the repository list
while read repo; do
  git clone "$repo"
  repo_name=$(basename "$repo" .git)
  cd "$repo_name"
  git fetch --all
  git branch -r | grep -v '\->' | while read remote; do
    branch_name="${remote#origin/}"
    if [ "$(git branch --list "$branch_name")" ]; then
      echo "Branch '$branch_name' already exists. Skipping..."
    else
      git branch --track "$branch_name" "$remote"
    fi
  done
  cd ..
done < repo_list.txt

#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo 'Missing commit message.'
    exit 0
fi

# Ensure we're on src and commit source files.
git checkout src
git add --all
git commit -m "[Source] $1"

# Build assets, move into repo root
reveal-md slides/ --static _static
mv _static/* .
rm favicon.ico

# Deploy assets to gh-pages
git add --all
git checkout gh-pages
git commit -m "[Assets] $1"

# Return to src, remove assets
git checkout src
git reset --hard

# Deploy all changes
git push --all

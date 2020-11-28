#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo 'Missing commit message.'
    exit 0
fi

# Ensure we're on src and commit source files.
git checkout src
git add --all
git commit -m "[Source] $1"

# Build assets, deploy to gh-pages
reveal-md slides/ --static dist
cp README.md dist/README.md
rm dist/favicon.ico
ghp-import -n -m "[Assets] $1" dist

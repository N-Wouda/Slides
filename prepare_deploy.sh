#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo 'Missing commit message.'
    exit 0
fi

# Ensure we're on src and commit source files.
git checkout src
git add --all
git commit -m "[Source] $1"

# Build assets
reveal-md slides/ --static dist

# I use a nested structure for my presentations, with each presentation in
# a separate folder. This means each presentation can be called "index.html"
# - the folder is already unique!
for f in dist/*/*.html; do
  # Based on https://stackoverflow.com/a/1322126/4316405
  dn=$(dirname $f)
  mv -f "$f" "$dn/index.html"
done

cp README.md dist/README.md
cp -a plugin/ dist/_assets/
rm dist/favicon.ico
rm dist/index.html

# Deploy to gh-pages
ghp-import -n -m "[Assets] $1" dist

#!/usr/bin/env sh
# Package the plugin as a zip for HTTPS "archive" marketplace hosting.
# Uses git archive so only committed files ship and the output is reproducible.
set -eu
version=$(sed -n 's/.*"version": "\(.*\)".*/\1/p' .claude-plugin/plugin.json)
out="dist/qlaris-${version}.zip"
mkdir -p dist
git archive --format=zip -o "$out" HEAD
echo "$out"
shasum -a 256 "$out"

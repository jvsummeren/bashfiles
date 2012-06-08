#!/bin/bash

echo "Removing .DS_store files:"
find . -name ".DS_Store" -depth -exec rm {} \; -print

echo "Removing ._* files:"
find . -iname '._*' -exec rm -rf {} \; -print

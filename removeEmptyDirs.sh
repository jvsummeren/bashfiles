#!/bin/bash

echo "Removing empty dirs (leave .svn dirs):"
find . -depth -type d -empty -not -path '*.svn*' -exec rmdir {} \; -print
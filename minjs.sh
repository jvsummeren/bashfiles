#!/bin/bash

tmpfile="tmpfile.js"
DIRECTORY="../cache/"

if [ ! -d "$DIRECTORY" ]; then
	mkdir $DIRECTORY
fi

if [ -e files ]; then
	input=`cat files`
else
	input=$@
fi

echo "Files added: $input"
cat $input > $tmpfile
jshash=`shasum $tmpfile | cut -c 1-8`
newfilegcc=../cache/$jshash.js

if [ -f $newfilegcc ]; then
	echo "$jshash.js already exists"
else 
	echo "Compressing JS with Google Closure Compiler"
	closure --js=$tmpfile --js_output_file=$newfilegcc --compilation_level=SIMPLE_OPTIMIZATIONS  --warning_level=QUIET
fi

echo ""
#gzip -c9v $newfile > $newfile.gz

rm -f $tmpfile

echo ""
ls -lash $DIRECTORY$jshash*

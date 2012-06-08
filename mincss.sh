#!/bin/bash

tmpfile="tmpfile.css"
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
csshash=`shasum $tmpfile | cut -c 1-8`
newfile=$DIRECTORY$csshash.css

if [ -f $newfile ]; then
	echo "$csshash.css already exists"
else 
	echo "Compressing CSS with YUI Compressor"
	yuicompressor $tmpfile > $newfile
fi

rm -f $tmpfile

echo ""
ls -lash $newfile*

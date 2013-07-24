#!/bin/bash

# Introduction

echo
echo                   "FLACCUE2FLAC"
echo
echo "This script will convert, split and tag FLAC files with an associated cue sheet"
echo
echo "WARNING: THIS SCRIPT WILL AUTOMATICALLY INSTALL SOME NECESSARY PACKAGES IF NOT ALREADY INSTALLED"
echo

# This will check if all packages needed are present in the system, and will install them if not.

FLAC=`which flac`
if [ -z $FLAC ]; then
	echo "ERROR (Don't worry) ;-)"
	echo "FLAC is not in your system, automatically installing..."
	sudo aptitude update && sudo aptitude install flac -y
	clear
	echo "OK NOW, PROCEEDING..."
	echo
fi

CUE=`which cuebreakpoints`
if [ -z $CUE ]; then
	echo "ERROR (Wish every error were like this one...) ;-)"
	echo
	echo "cuetools not present, automatically installing..."
	sudo aptitude update && sudo aptitude install cuetools -y
	clear
	echo "OK NOW, PROCEEDING..."
	echo
fi

SHN=`which shntool`
if [ -z $SHN ]; then
	echo "ERROR (Not the end of the world, anyway) ;-)"
	echo
	echo "shntool is not around here, let's get it..."
	sudo aptitude update && sudo aptitude install shntool -y
	clear
	echo "OK, PROCEEDING..."
	echo
fi

LL=`which lltag`
if [ -z $LL ]; then
	echo "OH, MY GOD! ;-)"
	echo
	echo "lltag is not in your computer, installing..."
	sudo aptitude update && sudo aptitude install lltag -y
	clear
	echo "AT LAST, PROCEEDING..."
	echo
fi

# Now it will check if we have chosen a cue file

for i in $*; do
	case ${i} in
		*.[cU][uU][eE])
			echo "Checking if file $i is a .cue file...";;
		*)
			echo "Warning: File $i is not a .cue file. Aborting."
			continue
	esac

	# Processing files

	FILENAME="$(basename ${i})"
	FILENAME="${FILENAME%.[cC][uU][eE]}"

	echo "Splitting files..."
	cuebreakpoints  $FILENAME.cue
	shnsplit -o flac -f $FILENAME.cue $FILENAME.flac

	echo "Adding tags..."
	cuetag $FILENAME.cue split-track*.flac

	# This will rename files using the strucure "track-number title", the one I like, but it can be easyly changed using common parameters. Please read lltag manual for more information.

	echo "Renaming files..."
	lltag --yes --no-tagging --rename '%n %t' `ls split-track*.flac`
	echo
	echo
	echo "Process ended."
done

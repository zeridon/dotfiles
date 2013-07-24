#!/bin/bash

clear

# Introduction

echo                              "APECUE2FLAC"
echo
echo
echo
echo "This bash script will convert and split ape files with associated cue files"
echo
echo
echo "WARNING: THIS SCRIPT WILL INSTALL NECESSARY PACKAGES IF NOT ALREADY INSTALLED"
echo
echo
echo
echo

# This will check your system for dependencies, and install packages if needed

MAC=`which mac`
if [ -z $MAC ]; then
	echo "ERROR :-("
	echo "Monkey's Audio Codec is not in your system"
	echo "Do a Google search (it's easy to install, but it's not in the repositories). I suggest you to add the Eudoxos repositories (http://ppa.launchpad.net/eudoxos/ubuntu yourubuntuversion main), or you may prefer to download this deb: http://members.iinet.net.au/~aidanjm/mac-3.99-u4_b3-1_i386.deb"
	exit -1
fi

FLAC=`which flac`
if [ -z $FLAC ]; then
	echo "ERROR (Don't worry) ;-)"
	echo "flac not found, automatically installing"
	sudo aptitude update && sudo aptitude install flac -y
	clear
	echo "EVERYTHING OK, PROCEEDING..."
	echo
fi

CUE=`which cuebreakpoints`
if [ -z $CUE ]; then
	echo "ERROR (Don't worry) ;-)"
	echo
	echo "cuetools not found, automatically installing..."
	sudo aptitude update && sudo aptitude install cuetools -y
	clear
	echo "EVERYTHING OK, PROCEEDING..."
	echo
fi

SHN=`which shntool`
if [ -z $SHN ]; then
	echo "ERROR (Don't worry) ;-)"
	echo
	echo "shntool not found, automatically installing..."
	sudo aptitude update && sudo aptitude install shntool -y
	clear
	echo "EVERYTHING OK, PROCEEDING..."
	echo
fi

LL=`which lltag`
if [ -z $LL ]; then
	echo "ERROR (Don't worry) ;-)"
	echo
	echo "lltag not found, automatically installing..."
	sudo aptitude update && sudo aptitude install lltag -y
	clear
	echo "EVERYTHING OK, PROCEEDING..."
	echo
fi

# The following will verify if we have chosen a cue file, and exits if not

for i in $*; do
	case $i in
		*.[cU][uU][eE])
			echo "Verifying file $i has a cue extension...";;
		*)
			echo "Warning: file $i is not a cue file. Aborting."
			continue
	esac

	FILENAME="$(basename $i)"
	FILENAME="${FILENAME%.[cC][uU][eE]}"

	# Processes files

	echo "Splitting files..."
	cuebreakpoints  $FILENAME.cue
	shnsplit -o flac -f $FILENAME.cue $FILENAME.ape

	echo "Adding tags..."
	cuetag $FILENAME.cue split-track*.flac
	echo

	# Now it renames files this way: "song-number title", but this can be changed as liked,
	# using common parameters. Please read lltag manual for more information.

	echo "Renaming files..."
	lltag --yes --no-tagging --rename '%n %t' `ls split-track*.flac`
	echo
	echo
	echo "End."
done

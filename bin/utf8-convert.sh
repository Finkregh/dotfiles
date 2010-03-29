#!/bin/sh

Usage() {
	ProgName=`basename "$0"`
	echo "find names with invalid UTF8 encoding.
Usage: $ProgName [[-r] [-f] paths(s) ...]

If no path(s) specified then the currrent directory is assumed."
	exit
}

for arg
do
	case "$arg" in
	-h|--help|-help|-?)
		Usage ;;
	-v|--version)
		Version ;;
	*)
		argsToPassOn="$argsToPassOn '$arg'" ;;
	esac
done

for file in `find $node -type f`; do
	for encoding in ASCII ISO-8859; do
		if file $file | grep -q $encoding ; then
			tempfile=`mktemp /tmp/secureXXXXXXXX`
			[ $encoding = "ISO-8859" ] && encoding=ISO-8859-15
			iconv -f $encoding -t UTF-8 $file -o $tempfile && mv $tempfile $file || echo "move/convert of $file/$tempfile did not work!"
		fi
	done
done

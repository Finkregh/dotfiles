#!/bin/bash

dir=$(pwd)

if [ -z "$1" ]; then
	find -name '*.[1-9]*' ! -path './debian/*' -type f -exec sh ${dir}/$0 \{\} \;
else
	file $1 | grep -q troff && echo $1
fi

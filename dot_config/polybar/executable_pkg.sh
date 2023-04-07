#!/bin/bash
pkg=$(packer --quickcheck 2> /dev/null | wc -l)

echo " $pkg"

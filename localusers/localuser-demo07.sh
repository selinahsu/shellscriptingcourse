#!/bin/bash

# This is playing with while loops and shift

while [[ "${#}" -ne 0  ]]
do
	echo "There are ${#} arguments left"
	shift
done

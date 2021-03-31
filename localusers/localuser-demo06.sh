#!/bin/bash

# This script generates a random password for each user specified on the command line.

# Display what the user executed, in positional command $0
echo "You executed this command: ${0}"

# Display path and filename
echo "You used $(dirname ${0}) as the path to this script: $(basename ${0})"

# Display how many parameters were received
echo "You supplied ${#} arguments on the command line"

# Make sure the user supplied at least 1 extra argument
if [[ "$#" -lt 1 ]]
then
	echo "Please include at least 1 argument when running on the command line."
	exit 1
fi

# Generate a random password for each arg ("${@}" provides all args wrapped in quotes)
for ARG in "${@}"
do
	echo "${ARG}: $(date +%s%N | sha256sum | head -c48)"
done

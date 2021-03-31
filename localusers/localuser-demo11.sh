#!/bin/bash

# This script uses getopts to generate a password
# The user can set the password length with -l, include a special character with -s, and/or enable verbose mode with -v

# Default password length, when there is no user input
LENGTH=48

display_usage() {
	echo 'Invalid options inputted.' >&2
	echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
	exit 1
}

verbose_log() {
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]] # '-eq' is for numbers, '=' is for strings
	then
		echo "${MESSAGE}"
	fi
}

# getopts must be used in a while loop because we don't know how many arguments the user will include
# The colon after l: means that an additional argument (the length value) must be included right after it
while getopts vl:s OPTION
do
	case ${OPTION} in 
	v)
		VERBOSE='true'
		echo 'Verbose mode on.'
		;;
	l)
		# OPTARG is a keyword for the argument following -l
		LENGTH="${OPTARG}"
		;;
	s)
		USE_SPECIAL_CHAR='true'
		;;
	?)
		display_usage
		;;
	esac
done

verbose_log "Generating a password..."

# Set a password of the default of a user-specified length
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Add a special character if it was requested
if [[ "${USE_SPECIAL_CHAR}" = 'true' ]]
then
	verbose_log "Selecting a special character..."
	SPECIAL_CHAR=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf | head -c1)
	PASSWORD="${PASSWORD}${SPECIAL_CHAR}"
fi

echo 'This is your password: '
echo "${PASSWORD}"


# Show that getopts does NOT affect positional parameters
echo "There are ${#} arguments"
echo "These are all the arguments: ${@}"
echo "This is the first arg: ${1}"
echo "This is the second arg: ${2}"
echo "This is the third arg: ${3}"


# What is OPTIND ? 
# It stores the position of the first argument that is NOT a flag/option
echo "This is OPTIND: ${OPTIND}"


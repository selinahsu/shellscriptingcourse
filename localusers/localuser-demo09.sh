#!/bin/bash

# This script demonstrates the case statement.

# Echo the file name
echo ${0}

# Check the pattern of the first argument passed in
case "${1}" in
	start)	echo 'Starting' ;;
	stop) 	echo 'Stopping' ;;
	status|state) 	echo 'Status' ;;
	*) 	
		echo 'Please supply a valid argument'
		exit 1
	;;
esac

# This is the UGLY way with if statements
# if [[ "${1}" = 'start' ]]
# then 
# 	echo 'Starting'
# elif [[ "${1}" = 'stop' ]] 
# then 
# 	echo 'Stopping'
# elif [[ "${1}" = 'status' ]]
# then
# 	echo 'Status'
# else
# 	echo 'Please supply a valid argument'
# 	exit 1
# fi

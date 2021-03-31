#!/bin/bash

# Display the UID and username of the user executing this script.
# Also display if the user is vagrant or not. 

# Display UID (a built-in shell variable)
echo "Your UID is ${UID}"

# If UID!=1000, display that the user is NOT vagrant
TEST_UID=1000
if [[ "${UID}" -ne "${TEST_UID}" ]]
then 
	echo "Your UID is not ${TEST_UID}"
	# Use a nonzero exit status for a failed script
	exit 1
fi

# Display username with the whoami command
USERNAME=$(id -un)
# Check that we successfully got the username
if [[ $? -ne 0 ]]
then
	echo "We were not able to determine your username"
	exit 1
else
	echo "Your username is ${USERNAME}"
fi

# Display if the username matches "vagrant"
TEST_USERNAME=vagrant
if [[ "$USERNAME" = "$TEST_USERNAME" ]]
then
	echo "Your username matches $TEST_USERNAME"
fi
# Display if the username does NOT match "vagrant"
if [[ "$USERNAME" != "sudo" ]]
then
	echo "Your username does NOT match sudo"
fi

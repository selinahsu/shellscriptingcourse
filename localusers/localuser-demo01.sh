#!/bin/bash

# Display the UID, username, and root/non-root status of the 
# user executing this script. 

FIRSTWORD=Hello
SECONDWORD=World

echo "${FIRSTWORD} ${SECONDWORD}"

# Fun fact: id -un does the same thing as the whoami command
USER_NAME=$(id -un)

echo "Your UID is ${UID}"
echo "Your username is ${USER_NAME}"

# The outcome of this block depends on using sudo or not
if [[ "${UID}" -eq 0 ]]
then 
	echo You are root.
else
	echo You are NOT root. 
fi

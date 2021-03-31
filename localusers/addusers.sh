#!/bin/bash

# This script creates an account on the local system. 
# You will be prompted for a username and password. 

# Ensure the script is being run with superuser privileges
if [[ "${UID}" -ne 0 ]]
then 
	echo "Please run this script with sudo."
	exit 1
fi

# Ask for username
read -p "Enter the username to create: " USERNAME

# Ask for name
read -p "Enter the name of the user: " COMMENT

# Ask for password
read -p "Enter the account password: " PASSWORD

# Create user, c flag for comment, m flag for creating a home directory
useradd -c "${COMMENT}" -m "${USERNAME}"
if [[ "$?" -ne 0 ]]
then
	echo "Something went wrong with user creation."
	exit 1
fi

# Set password
echo ${PASSWORD} | passwd --stdin ${USERNAME}
if [[ "$?" -ne 0 ]]
then
	echo "Something went wrong with password creation."
	exit 1
fi

# Make the user change their password on first login with the e (expire) flag
passwd -e ${USERNAME}

# Display the user that was created: (HOSTNAME is a built-in variable)
echo
echo "username: ${USERNAME}"
echo "passowrd: ${PASSWORD}"
echo "hostname: ${HOSTNAME}"


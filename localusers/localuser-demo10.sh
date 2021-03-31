#!/bin/bash

# This script demonstrates the use of function

# log() sends a message to syslog, and displays to STDOUT if VERBOSE=true
log() {
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" -eq 'true' ]]
		then echo "$MESSAGE"
	fi
	# save the msg to built-in syslog with the tag localuser
	logger -t localuser-demo10.sh "${MESSAGE}"
}

# backup_file() creates a backup in /var/tmp/
backup_file() {
	local FILE="${1}"

	# Check that the file exists, and is actually a file (not folder)
	if [[ -f "${FILE}" ]]
		then 
			local BACKUP_DIR="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
			log "Backing up ${FILE} to ${BACKUP_DIR}"

			# The exit status of cp becomes the exit status of the function
			# The -p flag preserves the timestamp of the file
			cp -p ${FILE} ${BACKUP_DIR}
	else
		return 1
	fi
}

# Set VERBOSE as an unchangeable value
readonly VERBOSE='true'

log 'Hello' 'this should print' 'to the terminal'

# Backup the /etc/passwd file to /var/tmp/
backup_file '/etc/passwd'

# Check the exit status of backup_file()
if [[ $? -eq 0 ]] 
	then log 'File backed up successfully.'
	else 
		log 'File backup failed.'
		exit 1
		# Even though the function's exit status is 1, you still need to set the exit status of the script file itself to 1
fi

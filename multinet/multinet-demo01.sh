#!/bin/bash

# This script pings a list of servers and reports their statuses.

SERVER_FILE='/vagrant/servers.txt'

if [[ ! -e ${SERVER_FILE} ]]
then
	echo "Cannot open ${SERVER_FILE}"
	exit 1
fi

for SERVER in $(cat ${SERVER_FILE})
do
	echo "Pinging ${SERVER}"
	ping -c 3 ${SERVER} &> /dev/null
	if [[ "$?" -ne 0 ]]
	then
		echo "The host ${SERVER} is unreachable."
		exit 1
	else 
		echo "${SERVER} is up."
	fi
done

exit 0

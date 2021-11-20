#!/bin/bash 

# This script runs a command on multiple hosts via SSH.

# Help message to display if flags are invalid
usage() {
	echo "USAGE: ${0} [-f FILE] [-nsv] COMMAND" >&2
	echo "  -f FILE Provide a list of servers to override the default file." >&2
	echo "  -n      Perform a dry run, where commands are displayed rather than executed." >&2
	echo "  -s      Run ssh commands with sudo privileges." >&2
	echo "  -v      Enable on verbose mode." >&2
	exit 1
}

# Check that the script is NOT run with root privileges
if [[ ${UID} -eq 0 ]]
then
	echo "Do NOT execute this script as root. Use the -s flag instead."
	exit 1
fi

SERVER_LIST="/vagrant/servers.txt"
DRY_RUN='false'
SUDO=''
VERBOSE='false'
SSH_OPTIONS='-o ConnectTimeout=2'

# Parse the positional arguments
while getopts f:nsv OPTION 
do
	case ${OPTION} in
	 f)
	   SERVER_LIST=${OPTARG}
	   echo "Searching for servers listed in ${SERVER_LIST}"
	   ;;
	 n)
	   DRY_RUN='true'
	   echo "Dry run on, printing commands: "
	   ;;
	 s)
	   SUDO='sudo'
	   echo "Running ssh commands with sudo."
	   ;;
	 v)
	   VERBOSE='true'
	   echo "Verbose mode on."
	   ;;
	 ?)
	   echo "Invalid flag: ${OPTION}"
	   usage
	esac
done

# Remove the arguments that have been processed by getopts 
shift $(( $OPTIND - 1 ))

# If there are no arguments left, that means a command was not given
if [[ $# -lt 1 ]]
then
	echo "No command provided. " >&2
	usage
fi

# Anything that remains on the command line is treated as the command to be run on the hosts
COMMAND="${@}"

# Make sure the server list file exists
if [[ ! -e ${SERVER_LIST} ]]
then
	echo "${SERVER_LIST} cannot be found." >&2
	exit 1
fi 

# Run the command in each host via SSH: 
for SERVER in $(cat ${SERVER_LIST}) 
do
	if [[ ${VERBOSE} = 'true' ]]
		then echo "Current host: ${SERVER}"
	fi
	SSH_CMD="ssh ${SSH_OPTIONS} ${SERVER} ${SUDO} ${COMMAND}"
	if [[ ${DRY_RUN} = 'true' ]]
		then echo ${SSH_CMD}
	else
		${SSH_CMD}
		EXIT_STATUS=$?
		if [[ ${EXIT_STATUS} -ne 0 ]]
		then echo "Execution on ${SERVER} failed with exit code ${EXIT_STATUS}" >&2	
		fi
	# continue looking at other servers despite this exit status issue
	fi
done

exit 0

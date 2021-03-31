#!/bin/bash

# This script demonstrates I/O redirection

# Redirect STDOUT to this file
FILE="./tempfile.txt"
# Redirect the first line of /etc/passwd into our file
head -n1 /etc/passwd > ${FILE}

# Redirect one line of STDIN to a variable
read LINE < ${FILE}
echo
echo "LINE variable contains: ${LINE}"

# Overwrite a file from STDOUT
echo "This is an overwrite" > ${FILE}

# Append STDOUT to a file with double operators
echo "Here are some more lines: " >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}

# Print the contents of the resulting file
echo
echo "These are the contents of ${FILE}:"
cat ${FILE}

# Redirect STDERR to a file using FD 2 (STDOUT will print to terminal)
ERR_FILE="./errfile.txt"
head -n3 /etc/passwd /nonexistentfile 2> ${ERR_FILE}

# Print the contents of the resulting error log file
echo
echo "These are the contents of ${ERR_FILE}:"
cat ${ERR_FILE}

# Redirect STDOUT and STDERR to the same file
head -n3 /etc/passwd /nonexistentfile &> ${FILE}
echo
echo "These are the contents of ${FILE} with combined redirection:"
cat ${FILE}

# Allow STDERR to pass through a pipe
echo
head -n1 /etc/passwd /nonexistentfile |& cat -n

# Redirect STDOUT to STDERR (echo will not pass through the pipe)
echo
echo "This is a STDERR" >&2 | cat -n 

echo "Discarding STDOUT and STDERR, so nothing should print after this"
# Use the NULL device to throw input/output away
head -n1 /etc/passwd /nonexistentfile &> /dev/null



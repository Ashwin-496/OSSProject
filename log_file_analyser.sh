#!/bin/bash

# Check if file argument is given
if [ -z "$1" ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

LOG_FILE=$1

# Check if file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File not found!"
    exit 1
fi

# Initialize counters
error_count=0
warning_count=0
total_lines=0

# Read file line by line
while read line
do
    total_lines=$((total_lines + 1))

    # Check for ERROR
    if echo "$line" | grep -q "ERROR"; then
        error_count=$((error_count + 1))
    fi

    # Check for WARNING
    if echo "$line" | grep -q "WARNING"; then
        warning_count=$((warning_count + 1))
    fi

done < "$LOG_FILE"

# Print summary
echo "====== LOG ANALYSIS SUMMARY ======"
echo "Total lines: $total_lines"
echo "ERROR lines: $error_count"
echo "WARNING lines: $warning_count"

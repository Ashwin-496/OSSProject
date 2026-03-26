#!/bin/bash

OUTPUT_FILE="log_analysis_report.txt"

echo "====== LOG FILE ANALYSIS REPORT ======" > $OUTPUT_FILE
echo "Generated on: $(date)" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Detect log source
if [ -f /var/log/auth.log ]; then
    LOG_DATA=$(cat /var/log/auth.log)
    SOURCE="Using /var/log/auth.log"
else
    LOG_DATA=$(journalctl _COMM=sshd 2>/dev/null)
    SOURCE="Using journalctl (systemd logs)"
fi

echo "Log Source: $SOURCE" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 1. Failed login attempts
echo "---- Failed Login Attempts ----" >> $OUTPUT_FILE
FAILED_COUNT=$(echo "$LOG_DATA" | grep "Failed password" | wc -l)
echo "Total Failed Logins: $FAILED_COUNT" >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE
echo "Top IPs with Failed Attempts:" >> $OUTPUT_FILE
echo "$LOG_DATA" | grep "Failed password" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head -5 >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE

# 2. Successful logins
echo "---- Successful Logins ----" >> $OUTPUT_FILE
SUCCESS_COUNT=$(echo "$LOG_DATA" | grep "Accepted password" | wc -l)
echo "Total Successful Logins: $SUCCESS_COUNT" >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE

# 3. Invalid user attempts
echo "---- Invalid User Attempts ----" >> $OUTPUT_FILE
INVALID_USERS=$(echo "$LOG_DATA" | grep "Invalid user" | wc -l)
echo "Total Invalid User Attempts: $INVALID_USERS" >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE

# 4. SSH log summary
echo "---- SSH Log Summary ----" >> $OUTPUT_FILE
SSH_LOGS=$(echo "$LOG_DATA" | grep "sshd" | wc -l)
echo "Total SSH-related logs: $SSH_LOGS" >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE

# 5. Suspicious IP detection (>5 failed attempts)
echo "---- Suspicious IPs (More than 5 Failed Attempts) ----" >> $OUTPUT_FILE
echo "$LOG_DATA" | grep "Failed password" | awk '{print $(NF-3)}' | sort | uniq -c | awk '$1 > 5' >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE

echo "Analysis complete. Report saved as $OUTPUT_FILE"

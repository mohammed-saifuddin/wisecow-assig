#!/bin/bash
# Simple Web Server Log Analyzer
LOG_FILE="/var/log/apache2/access.log"   # Change path if needed

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "===== Web Server Log Analysis ====="
echo "Log File: $LOG_FILE"
echo

echo "Total Requests: $(wc -l < "$LOG_FILE")"

echo "Total 404 Errors: $(grep ' 404 ' "$LOG_FILE" | wc -l)"
echo
echo "Top 5 Requested Pages:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5
echo
echo "Top 5 IP Addresses:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5

# Status code summary
echo
echo "HTTP Status Code Summary:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr

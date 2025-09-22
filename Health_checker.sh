#!/bin/bash

URL="http://localhost:8080"
STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

if [[ "$STATUS_CODE" =~ ^2|3 ]]; then
    echo "Application is UP (Status: $STATUS_CODE)"
else
    echo "Application is DOWN (Status: $STATUS_CODE)"
fi

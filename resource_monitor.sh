#!/bin/bash

LOG_FILE="resource_usage.log"
CPU_THRESHOLD=80
DISK_THRESHOLD=20

get_resource_usage()
{ 
   CPU_USAGE=$(top -bn1|grep "Cpu(s)"|awk '{print $2 + $4}')
   MEMORY_USAGE=$(free -m |awk '/Mem:/ {printf ".2f" $3/$2 * 100}')
   DISK_USAGE=$(df / |awk 'NR==2 {printf ".2f" 100 - $4/$2 *100}')
   AVAILABLE_DISK_SPACE=$(df /|grep /|awk '{print $4}')
   RUNNING_PROCESS=$(ps aux)
   echo  "$(date) - CPU: ${CPU_USAGE}% | Memory: ${MEMORY_USAGE}% |  Disk:${DISK_USAGE}% | AVAILABLE_DISK_SPACE:${AVAILABLE_DISK_SPACE}% | RUNNING_PROCESS:${RUNNING_PROCESS}" >> "$LOG_FILE"

if (( $( echo "$CPU_USAGE > $CPU_THRESHOLD" ) ))
then 
   echo "CPU usage is high:$CPU_USAGE%"
else
   echo "Every thing is fine in CPUS"
fi


if (( AVAILABLE_DISK_SPACE < $DISK_THRESHOLD ))
then 
   echo "DISK usage is low: $AVAILABLE_DISK_SPACE%" | mail -s "low disk alert" "$EMAIL"
else
   echo "Every thing is fine in disk"
fi

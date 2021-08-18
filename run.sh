#!/bin/bash

timetorun=90
stoptime=$((timetorun + $(date +%s)))

# Check if Clair is UP!
echo "Checking Clair status..."

docker logs -f clair > clair.logs 2>&1

while [ true ]
do  
    if [[ $(date +%s) > $stoptime ]]; then
        echo "[Error]: Timeout waiting for Clair"
        cat clair.logs
        exit 1;
    fi
    
    curl http://localhost:6060 &> /dev/null 2>&1
    
    docker ps
    
    if [ "$?" -eq 0 ]; then
        echo "Ready!"
        exit 0;
    fi
    
    sleep 1;
done

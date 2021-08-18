#!/bin/bash

docker-compose up -d

timetorun=30
stoptime=$((timetorun + $(date +%s)))

# Check if Clair is UP!
while [ true ]
do
    if [[ $(date +%s) > $stoptime ]]; then
        break;
    fi
    
    curl http://localhost:6060 &> /dev/null 2>&1
    
    if [ "$?" -eq 0 ]; then
        echo "Ready!"
        exit 0
    fi
done

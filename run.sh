#!/bin/bash

docker-compose up -d

# Check if Clair is UP!
STOP=0
while [ true ]
do
    if [[ "$STOP" -eq 4 ]]; then
        echo "STOP!"
        break;
    fi
    curl http://localhost:6060 &> /dev/null 2>&1
    if [[ "$?" -eq 0 ]]; then
	echo "Clair is ready!"
        exit 0
    fi
    STOP=$STOP+1
done

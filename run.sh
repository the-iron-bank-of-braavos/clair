#!/bin/bash

docker-compose up -d

# Check if Clair is UP!
while [ true ]
do
    curl http://localhost:6060 &> /dev/null
    if [[ "$?" -eq 0 ]]; then
	echo "Clair is ready!"
        exit 0
    fi
done

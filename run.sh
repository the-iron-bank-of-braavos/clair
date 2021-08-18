#!/bin/bash

<<<<<<< HEAD
docker-compose up -d

# Check if Clair is UP!
while [ true ]
do
    curl http://localhost:6060 &> /dev/null
    if [[ "$?" -eq 0 ]]; then
	echo "Clair is ready!"
        exit 0
    fi
=======
timetorun=120
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
    
    curl --max-time 5 http://localhost:6060 &> /dev/null 2>&1
    
    if [ "$?" -eq 0 ]; then
        echo "Ready!"
        exit 0;
    fi
    
    sleep 3;
>>>>>>> a203d1f2f0bbbdb363b35971bfe46b25ff97cb59
done

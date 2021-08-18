#!/bin/bash

timetorun=30
stoptime=$((timetorun + $(date +%s)))

echo "Checking postgres status..."
docker logs -f postgres > postgres.logs 2>&1

while [ true ]
do  
    if [[ $(date +%s) > $stoptime ]]; then
        echo "[Error]: Timeout waiting for Postgres"
        cat clair.logs
        exit 1;
    fi
    
    docker exec postgres psql -U clair -d clair &> /dev/null 2>&1
    
    if [ "$?" -eq 0 ]; then
        echo "Postgres is ready!"
        docker-compose -f $GITHUB_ACTION_PATH/docker-compose.yml up -d registry clair
        break;
    fi
    
    sleep 1;
done

timetorun=30
stoptime=$((timetorun + $(date +%s)))

echo "Checking clair status..."
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
        echo "Clair is ready!"
        break;
    fi
    
    sleep 1;
done

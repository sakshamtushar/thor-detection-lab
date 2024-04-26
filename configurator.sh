#!/bin/bash

#docker-compose -f splunk-compose_v2.yml up -d
SPLUNK_URL="https://192.168.0.108:8089"
PASSWORD="thor-lab@123"
INDEX="main" 
ENDPOINT="${SPLUNK_URL}/services/data/inputs/http/"

#disable SSL in HEC Global Settings
curl -k -u admin:$PASSWORD $SPLUNK_URL/servicesNS/nobody/search/data/inputs/http/http -d  enableSSL=0
# Create the JSON payload for the HEC collector
response=$(curl -k -u admin:$PASSWORD $SPLUNK_URL/servicesNS/nobody/search/data/inputs/http -d name=elastic-input-test -d index=main -d indexes=main)
if echo "$response" | grep -q '"token"'; then
    # Extract the token from the response
    token=$(echo "$response" | grep token | cut -d '>' -f 2  | cut -d '<' -f 1)
    echo "HEC token created successfully: $token"
    echo "SPLUNK_TOKEN=$token" >> .env

else
    echo "Failed to create HEC collector: $response"
    exit
fi

./elastic-container.sh start
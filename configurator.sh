
#!/bin/bash


#docker-compose -f spllunk-compose_v2.yml up -d
SPLUNK_URL="https://192.168.0.108:8089"
PASSWORD="thor-lab@123"
INDEX="main" 
ENDPOINT="${SPLUNK_URL}/services/data/inputs/http/"

# Create the JSON payload for the HEC collector
curl -k -u admin:$PASSWORD $SPLUNK_URL/servicesNS/nobody/search/data/inputs/http -d name=elastic-input -d index=main -d indexes=main 
if echo "$response" | grep -q '"token"'; then
    # Extract the token from the response
    token=$(echo "$response" | | grep token | cut -d '>' -f 2  | cut -d '<' -f 1)
    echo "HEC token created successfully: $token"
    echo "Token=Splunk $token" >> .env

else
    echo "Failed to create HEC collector: $response"
    exit
fi


#!/bin/bash


#docker-compose -f spllunk-compose_v2.yml up -d
SPLUNK_URL="https://192.168.0.108:8089"
PASSWORD="Saksham@80100"
INDEX="main" 
ENDPOINT="${SPLUNK_URL}/services/data/inputs/http/"

# Create the JSON payload for the HEC collector
curl -k -u admin:$PASSWORD $SPLUNK_URL/servicesNS/nobody/search/data/inputs/http -d name=elastic-input -d index=main -d indexes=main #| grep token | cut -d '>' -f 2  | cut -d '<' -f 1
if echo "$response" | grep -q '"token"'; then
    # Extract the token from the response
    token=$(echo "$response" | grep -oP '"token":"\K[^"]+')
    echo "HEC token created successfully: $token"
else
    echo "Failed to create HEC collector: $response"
fi
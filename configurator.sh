#!/bin/bash
#sudo apt-get install docker-compose
docker-compose -f splunk-compose_v2.yml up -d

get_health_status() {
    docker inspect --format='{{.State.Health.Status}}' "splunk-thorlab"
}
while true; do
    health_status=$(get_health_status)
    if [[ "$health_status" == "healthy" ]];  # Check if health status is "healthy"
    then
        echo "Container 'splunk-thorlab' is healthy."
        break
    else
        echo "Waiting for container 'splunk' to become healthy (current status: $health_status)."
        # Wait for 5 seconds before checking again
        sleep 5
    fi
done

echo "configuring splunk HEC & Disabling HEC Global SSL Configuration..."
SPLUNK_URL="https://192.168.0.138:8089"
PASSWORD="thor-lab@123"
INDEX="main" 
ENDPOINT="${SPLUNK_URL}/services/data/inputs/http/"

#disable SSL in HEC Global Settings
curl -k -u admin:$PASSWORD $SPLUNK_URL/servicesNS/nobody/search/data/inputs/http/http -d  enableSSL=0
# Create the JSON payload for the HEC collector
response=$(curl -k -u admin:$PASSWORD $SPLUNK_URL/servicesNS/nobody/search/data/inputs/http -d name=elastic-input-test -d index=main -d indexes=main)
if echo "$response" | grep -E -q 'token|already'; then
    # Extract the token from the response
    token=$(echo "$response" | grep token | cut -d '>' -f 2  | cut -d '<' -f 1)
    echo "HEC token created successfully: $token"
    echo "SPLUNK_TOKEN=$token" >> .env

else
    echo "Failed to create HEC collector: $response"
    exit
fi
echo "Setting up & Configuring Elastic"
./elastic-container.sh start
#!/bin/bash

# Function to check if a container is already running
is_container_running() {
  local tool_name=$1
  docker ps --format '{{.Names}}' | grep -q "$tool_name"
}

# Function to spin up the tool using docker-compose
spin_up_tool() {
  local tool_name=$1
  local tool_dir=$2
  
  if [ -d "$tool_dir" ]; then
    echo "Navigating to $tool_dir..."
    cd "$tool_dir"
    
    if [ -f "docker-compose.yml" ]; then
      # Extract the service name from the docker-compose file
      local service_name=$(docker-compose config --services | head -n 1)
      
      if is_container_running "$service_name"; then
        echo "$tool_name is already running."
      else
        echo "Spinning up $tool_name..."
        docker-compose up -d
        echo "$tool_name is now running."
      fi
    else
      echo "Error: docker-compose.yml not found in $tool_dir."
    fi
    
    # Navigate back to the original directory
    cd - > /dev/null
  else
    echo "Error: Directory $tool_dir does not exist."
  fi
}

# Main script execution
echo "Choose a tool to spin up:"
echo "1) Splunk"
echo "2) Elastic SIEM"
echo "3) Cribl"
echo "4) n8n SOAR"
echo "5) Shuffle"
echo "6) Exit"

read -p "Enter the number corresponding to your choice: " choice

case $choice in
  1)
    spin_up_tool "Splunk" "splunk"
    ;;
  2)
    spin_up_tool "Elastic SIEM" "elastic-siem"
    ;;
  3)
    spin_up_tool "Cribl" "cribl"
    ;;
  4)
    spin_up_tool "n8n SOAR" "n8n-soar"
    ;;
  5)
    spin_up_tool "Shuffle" "shuffle"
    ;;
  6)
    echo "Exiting the script."
    exit 0
    ;;
  *)
    echo "Invalid choice. Please select a valid option."
    ;;
esac

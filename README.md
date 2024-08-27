# Thor (Threat Detection & Open Research) - Threat Detection Lab

## overview: 
  The Thor Detection Lab is a modular and scalable environment designed for security professionals to deploy, test, and analyze various security tools and technologies. This lab provides Docker-based deployments of several key security tools such as Splunk, Elastic SIEM, Cribl, n8n SOAR, and Shuffle.

## features:
  - **Easy Deployment**: Deploy multiple security tools with Docker and Docker Compose.
  - **Modular Design**: Choose and deploy only the tools you need.
  - **Automated Setup**: Scripted configuration for hassle-free setup and management.
  - **Tool Options**: Spin up different tools based on your specific needs.

## prerequisites:
  - Docker
  - Docker Compose
  - Bash shell (for running the provided script)

## available_tools:
  - **Splunk**: A powerful platform for searching, monitoring, and analyzing machine-generated big data via a web-style interface.
  - **Elastic SIEM**: A security information and event management solution built on the Elastic Stack.
  - **Cribl**: An observability pipeline that allows you to collect, reduce, and route data.
  - **n8n SOAR**: An open-source workflow automation tool that helps security teams automate tasks.
  - **Shuffle**: A security orchestration, automation, and response (SOAR) platform.

## setup_instructions:
  - step: Clone the Repository
    ```bash
      git clone https://github.com/sakshamtushar/thor-detection-lab.git
      cd thor-detection-lab
  - step: Run the Spin-Up Script
    ```bash
      ./configurator.sh
  - step: Follow the On-Screen Prompts
    details: 
      The script will prompt you to select which tool you want to deploy:
      - Press `1` for Splunk
      - Press `2` for Elastic SIEM
      - Press `3` for Cribl
      - Press `4` for n8n SOAR
      - Press `5` for Shuffle
      - Press `6` to exit
  - step: Access the Tool
    details: 
      Once the tool is deployed, you can access it via its respective web interface (if applicable). The script will inform you of the relevant URLs and ports.

## notes:
  - The script checks if the tool is already running to avoid redundant operations.
  - Ensure Docker and Docker Compose are properly installed and running on your machine.

## guided tutorial (youtube): 
  - https://www.youtube.com/playlist?list=PLyakJX0xXQjdVJ8BDj-jd7xU8HPLKZJLn

## more content and details : 
  - https://sakshamtushar.notion.site/Threat-Detection-Lab-THOR-HQ-656c958745844b61930dd2e5c53849e6

## troubleshooting:
  - Tool Not Spinning Up: Ensure that Docker is running and there are no conflicts with the existing containers.
  - Port Conflicts: If you encounter port conflicts, you may need to adjust the `docker-compose.yml` file in the tool's directory.

## license: This project is licensed under the MIT License. See the LICENSE file for details.

## contributing: Contributions are welcome! Please open an issue or submit a pull request on GitHub.

## contact: For questions or support, please contact [Saksham Tushar](mailto:sakshamtushar@gmail.com).

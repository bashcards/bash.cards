#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Five of Hearts Card
five_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Five of Hearts                              |"
    echo "     |                      Phish User Credentials Stealthily                   |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides a lightweight interface for generating phishing      |"
    echo "     |  templates, launching phishing campaigns, and analyzing captured data.   |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Generate phishing templates                                          |"
    echo "     |  2. Launch phishing campaign                                             |"
    echo "     |  3. Analyze captured credentials                                         |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) generate_templates ;;
        2) launch_campaign ;;
        3) analyze_credentials ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; five_of_hearts_menu ;;
    esac
}

# Generate phishing templates
generate_templates() {
    clear
    echo -e "${CYAN}Generating phishing templates...${RESET}"
    read -p "Enter a target organization or user profile: " target
    echo "Creating phishing templates for $target..."
    # Simulate template generation
    sleep 2
    echo -e "${CYAN}Templates created successfully.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_hearts_menu
}

# Launch phishing campaign
launch_campaign() {
    clear
    echo -e "${CYAN}Launching phishing campaign...${RESET}"
    read -p "Enter the template file to use: " template
    if [[ -f "$template" ]]; then
        echo "Using template $template for the phishing campaign..."
        # Simulate campaign launch
        sleep 2
        echo -e "${CYAN}Phishing campaign launched successfully.${RESET}"
    else
        echo -e "${CYAN}Error: Template file $template not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_hearts_menu
}

# Analyze captured credentials
analyze_credentials() {
    clear
    echo -e "${CYAN}Analyzing captured credentials...${RESET}"
    read -p "Enter the credentials file to analyze: " file
    if [[ -f "$file" ]]; then
        echo "Analyzing credentials in $file..."
        # Simulate analysis
        sleep 2
        echo -e "${CYAN}Analysis complete. Results saved to analyzed_$file.${RESET}"
    else
        echo -e "${CYAN}Error: Credentials file $file not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_hearts_menu
}

five_of_hearts_menu

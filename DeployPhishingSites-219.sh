#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Eight of Hearts Card
eight_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Eight of Hearts                             |"
    echo "     |                          Deploy Phishing Sites                           |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides tools to deploy phishing sites for testing and       |"
    echo "     |  awareness purposes. Use with caution and only in ethical environments.  |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Start a phishing server                                              |"
    echo "     |  2. Deploy pre-built phishing templates                                  |"
    echo "     |  3. View server logs                                                     |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_phishing_server ;;
        2) deploy_templates ;;
        3) view_logs ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; eight_of_hearts_menu ;;
    esac
}

# Start a phishing server
start_phishing_server() {
    clear
    echo -e "${CYAN}Starting a phishing server...${RESET}"
    if command -v php &>/dev/null; then
        read -p "Enter the directory for the phishing site (default: ./phishing_site): " dir
        dir=${dir:-./phishing_site}
        mkdir -p "$dir"
        cd "$dir" || exit
        php -S 0.0.0.0:8080
    else
        echo -e "${CYAN}Error: PHP is not installed.${RESET}"
        echo "Please install PHP using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_hearts_menu
}

# Deploy pre-built phishing templates
deploy_templates() {
    clear
    echo -e "${CYAN}Deploying phishing templates...${RESET}"
    if [[ -d ./phishing_templates ]]; then
        echo "Available templates:"
        ls ./phishing_templates
        read -p "Enter the template name to deploy: " template
        if [[ -f ./phishing_templates/$template ]]; then
            cp -r ./phishing_templates/$template ./phishing_site
            echo -e "${CYAN}Template $template deployed successfully.${RESET}"
        else
            echo -e "${CYAN}Error: Template $template not found.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: No phishing templates directory found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_hearts_menu
}

# View server logs
view_logs() {
    clear
    echo -e "${CYAN}Viewing server logs...${RESET}"
    if [[ -f ./phishing_site/access.log ]]; then
        less ./phishing_site/access.log
    else
        echo -e "${CYAN}Error: No logs found. Ensure the server is running.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_hearts_menu
}

eight_of_hearts_menu

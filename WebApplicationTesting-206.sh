#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Two of Hearts Card
two_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Two of Hearts                              |"
    echo "     |                    Advanced Web Application Testing                     |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides an interface to launch and configure Burp Suite,    |"
    echo "     |  a powerful tool for web application penetration testing.               |"
    echo "     |                                                                         |"
    echo "     |                                                                         |"
    echo "     |  1. Start Burp Suite in GUI mode                                        |"
    echo "     |  2. Configure Proxy Settings                                            |"
    echo "     |  3. Import or Export Project Files                                      |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_burpsuite ;;
        2) configure_proxy ;;
        3) manage_projects ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; two_of_hearts_menu ;;
    esac
}

# Start Burp Suite in GUI mode
start_burpsuite() {
    clear
    echo -e "${CYAN}Launching Burp Suite...${RESET}"
    if command -v burpsuite &>/dev/null; then
        burpsuite &
    else
        echo -e "${CYAN}Error: Burp Suite is not installed.${RESET}"
        echo "Please install Burp Suite from https://portswigger.net/burp."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_hearts_menu
}

# Configure Proxy Settings
configure_proxy() {
    clear
    echo -e "${CYAN}Configuring Proxy Settings...${RESET}"
    echo "Enter the proxy host (default: 127.0.0.1):"
    read -p "> " proxy_host
    proxy_host=${proxy_host:-127.0.0.1}
    echo "Enter the proxy port (default: 8080):"
    read -p "> " proxy_port
    proxy_port=${proxy_port:-8080}
    echo -e "${CYAN}Proxy configured to ${proxy_host}:${proxy_port}.${RESET}"
    echo "Ensure your browser or tool is set to use this proxy."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_hearts_menu
}

# Import or Export Project Files
manage_projects() {
    clear
    echo -e "${CYAN}Manage Burp Suite Project Files${RESET}"
    echo "1. Import a project file"
    echo "2. Export a project file"
    read -p "Choose an option: " project_choice
    case $project_choice in
        1)
            echo "Enter the path to the project file to import:"
            read -p "> " import_path
            if [[ -f "$import_path" ]]; then
                echo -e "${CYAN}Project file $import_path imported successfully.${RESET}"
            else
                echo -e "${CYAN}Error: File $import_path not found.${RESET}"
            fi
            ;;
        2)
            echo "Enter the path to save the project file (e.g., /path/to/project.burp):"
            read -p "> " export_path
            echo -e "${CYAN}Project file saved to $export_path.${RESET}"
            ;;
        *)
            echo "Invalid choice. Returning to menu."
            ;;
    esac
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_hearts_menu
}

two_of_hearts_menu

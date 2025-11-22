#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Jack of Hearts Card
jack_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Jack of Hearts                              |"
    echo "     |                   Automate Social Engineering Attacks                    |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card integrates the Social-Engineer Toolkit (SET) for automating   |"
    echo "     |  phishing, spear phishing, and other social engineering attack vectors.  |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Launch SET Interactive Console                                       |"
    echo "     |  2. Run a predefined phishing campaign                                   |"
    echo "     |  3. View SET configuration files                                         |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) launch_set ;;
        2) run_phishing_campaign ;;
        3) view_set_config ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; jack_of_hearts_menu ;;
    esac
}

# Launch SET Interactive Console
launch_set() {
    clear
    echo -e "${CYAN}Launching Social-Engineer Toolkit (SET) Interactive Console...${RESET}"
    if command -v setoolkit &>/dev/null; then
        setoolkit
    else
        echo -e "${CYAN}Error: SET is not installed.${RESET}"
        echo "Please install the Social-Engineer Toolkit (SET) using your package manager or visit https://github.com/trustedsec/social-engineer-toolkit."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_hearts_menu
}

# Run a predefined phishing campaign
run_phishing_campaign() {
    clear
    echo -e "${CYAN}Running a predefined phishing campaign...${RESET}"
    if command -v setoolkit &>/dev/null; then
        read -p "Enter the phishing campaign configuration file (e.g., campaign.conf): " config_file
        if [[ -f "$config_file" ]]; then
            setoolkit -c "$config_file"
        else
            echo -e "${CYAN}Error: Configuration file $config_file not found.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: SET is not installed.${RESET}"
        echo "Please install the Social-Engineer Toolkit (SET) using your package manager or visit https://github.com/trustedsec/social-engineer-toolkit."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_hearts_menu
}

# View SET configuration files
view_set_config() {
    clear
    echo -e "${CYAN}Viewing SET configuration files...${RESET}"
    config_path="/etc/setoolkit"
    if [[ -d "$config_path" ]]; then
        ls "$config_path"
        read -p "Enter the filename to view (or type 'cancel' to return): " file_choice
        if [[ $file_choice == "cancel" ]]; then
            echo "Returning to menu..."
        elif [[ -f "$config_path/$file_choice" ]]; then
            less "$config_path/$file_choice"
        else
            echo -e "${CYAN}Error: File $file_choice not found.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: SET configuration directory not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_hearts_menu
}

jack_of_hearts_menu

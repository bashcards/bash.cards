#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[0;32m'

# Menu for the King of Clubs Card
king_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                               King of Clubs                             |"
    echo "     |                       Start a New Bash Shell Session                    |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to start a new Bash shell session and provides    |"
    echo "     |  tools to manage, customize, and troubleshoot your shell environment.   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Start a New Bash Session                                            |"
    echo "     |  2. View Current Bash Version                                           |"
    echo "     |  3. Export a Custom Bash Configuration                                  |"
    echo "     |  4. Load a Saved Bash Configuration                                     |"
    echo "     |  5. List Environment Variables                                          |"
    echo "     |  6. Return to Default Bash Configuration                                |"
    echo "     |  7. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) start_bash_session ;;
        2) view_bash_version ;;
        3) export_custom_config ;;
        4) load_saved_config ;;
        5) list_env_variables ;;
        6) return_to_default_config ;;
        7) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; king_of_clubs_menu ;;
    esac
}

# Option 1: Start a New Bash Session
start_bash_session() {
    clear
    echo -e "${CYAN}Starting a new Bash shell session...${RESET}"
    bash
    echo -e "${CYAN}You have exited the new Bash session.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

# Option 2: View Current Bash Version
view_bash_version() {
    clear
    echo -e "${CYAN}Bash Version:${RESET}"
    bash --version
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

# Option 3: Export a Custom Bash Configuration
export_custom_config() {
    clear
    echo -e "${CYAN}Exporting current Bash configuration...${RESET}"
    local config_file="bash_config_$(date +%Y%m%d%H%M%S).sh"
    declare -p > "$config_file"
    echo -e "${GREEN}Bash configuration saved to $config_file.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

# Option 4: Load a Saved Bash Configuration
load_saved_config() {
    clear
    echo -e "${CYAN}Available configuration files:${RESET}"
    ls -1 *.sh 2>/dev/null || echo "No configuration files found."
    read -p "Enter the filename to load: " config_file
    if [[ -f "$config_file" ]]; then
        source "$config_file"
        echo -e "${GREEN}Configuration $config_file loaded successfully.${RESET}"
    else
        echo -e "${CYAN}Error: File $config_file not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

# Option 5: List Environment Variables
list_env_variables() {
    clear
    echo -e "${CYAN}Environment Variables:${RESET}"
    env | less
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

# Option 6: Return to Default Bash Configuration
return_to_default_config() {
    clear
    echo -e "${CYAN}Reverting to default Bash configuration...${RESET}"
    mv ~/.bashrc ~/.bashrc.bak 2>/dev/null || echo "No existing .bashrc found to back up."
    cp /etc/skel/.bashrc ~/
    echo -e "${GREEN}Default configuration restored. Restart your shell for changes to take effect.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

# Option 7: Exit Script
exit_script() {
    clear
    exit 0
}

king_of_clubs_menu

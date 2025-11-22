#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Jack of Clubs Card
jack_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Jack of Clubs                              |"
    echo "     |                      Set Environment Variables                          |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to set, modify, and list environment variables.   |"
    echo "     |  Environment variables are crucial for controlling application behavior.|"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. View Current Environment Variables                                  |"
    echo "     |  2. Add or Modify an Environment Variable                              |"
    echo "     |  3. Make an Environment Variable Persistent                            |"
    echo "     |  4. Exit                                                               |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) view_env ;;
        2) add_modify_env ;;
        3) make_persistent_env ;;
        4) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; jack_of_clubs_menu ;;
    esac
}

# Option 1: View Current Environment Variables
view_env() {
    clear
    echo -e "${CYAN}Current Environment Variables:${RESET}"
    env | less
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

# Option 2: Add or Modify an Environment Variable
add_modify_env() {
    clear
    read -p "Enter the name of the environment variable: " var_name
    read -p "Enter the value for $var_name: " var_value
    export "$var_name=$var_value"
    echo -e "${CYAN}Environment variable $var_name set to $var_value.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

# Option 3: Make an Environment Variable Persistent
make_persistent_env() {
    clear
    read -p "Enter the name of the environment variable: " var_name
    read -p "Enter the value for $var_name: " var_value
    echo "export $var_name=$var_value" >> ~/.bashrc
    echo -e "${CYAN}Environment variable $var_name will persist across sessions.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

# Option 4: Exit Script
exit_script() {
    clear
    exit 0
}

jack_of_clubs_menu#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Jack of Clubs Card
jack_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Jack of Clubs                              |"
    echo "     |                        Set Environment Variables                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to set, modify, and list environment variables.   |"
    echo "     |  Environment variables are crucial for controlling application behavior.|"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. View Current Environment Variables                                  |"
    echo "     |  2. Add or Modify an Environment Variable                               |"
    echo "     |  3. Make an Environment Variable Persistent                             |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) view_env ;;
        2) add_modify_env ;;
        3) make_persistent_env ;;
        4) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; jack_of_clubs_menu ;;
    esac
}

# Option 1: View Current Environment Variables
view_env() {
    clear
    echo -e "${CYAN}Current Environment Variables:${RESET}"
    env | less
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

# Option 2: Add or Modify an Environment Variable
add_modify_env() {
    clear
    read -p "Enter the name of the environment variable: " var_name
    read -p "Enter the value for $var_name: " var_value
    export "$var_name=$var_value"
    echo -e "${CYAN}Environment variable $var_name set to $var_value.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

# Option 3: Make an Environment Variable Persistent
make_persistent_env() {
    clear
    read -p "Enter the name of the environment variable: " var_name
    read -p "Enter the value for $var_name: " var_value
    echo "export $var_name=$var_value" >> ~/.bashrc
    echo -e "${CYAN}Environment variable $var_name will persist across sessions.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

# Option 4: Exit Script
exit_script() {
    clear
    exit 0
}

jack_of_clubs_menu

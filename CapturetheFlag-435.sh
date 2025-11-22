#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

capture_the_flag() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________"
    echo "    |              Five of Clubs                |"
    echo "    |  Engage in Team-Based Security Challenges |"
    echo "    |___________________________________________|"
    echo -e "${RESET}"

    while true; do
        clear
        echo -e "${CYAN}Welcome to Capture the Flag (CTF) Challenges!${RESET}"
        echo "Choose an activity:"
        echo "1. Web Application Security Challenges"
        echo "2. Reverse Engineering Challenges"
        echo "3. Forensics Challenges"
        echo "4. Exit"
        read -p "Choice: " choice

        case $choice in
            1)
                clear
                echo -e "${CYAN}Web Application Security Challenges${RESET}"
                echo "Solve challenges that test your skills in web security."
                echo "Options:"
                echo "1. SQL Injection (Exploit a vulnerable input field)"
                echo "2. Cross-Site Scripting (Identify and execute an XSS payload)"
                echo "3. Directory Traversal (Access restricted directories)"
                echo -e "\nPress any key to return to the menu."
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Reverse Engineering Challenges${RESET}"
                echo "Analyze binary files to understand their functionality."
                echo "Options:"
                echo "1. Disassemble a binary file with 'objdump'."
                echo "2. Use 'strings' to extract readable text."
                echo "3. Debug the program using 'gdb'."
                echo -e "\nPress any key to return to the menu."
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Forensics Challenges${RESET}"
                echo "Investigate digital evidence to uncover hidden data."
                echo "Options:"
                echo "1. Use 'binwalk' to extract hidden files."
                echo "2. Analyze a memory dump with 'volatility'."
                echo "3. Investigate a network capture using 'Wireshark'."
                echo -e "\nPress any key to return to the menu."
                read -n 1 -s
                ;;
            4)
                echo -e "${CYAN}Exiting Capture the Flag Challenges...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Please try again.${RESET}"
                ;;
        esac
    done
}

capture_the_flag

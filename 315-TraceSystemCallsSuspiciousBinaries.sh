#!/bin/bash

CYAN='\033[1;36m'
RED='\033[1;31m'
RESET='\033[0m'

trace_system_calls() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                             Eight of Spades                              |"
        echo "    |              Trace System Calls from Suspicious Binaries                 |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Trace a specific binary                                              |"
        echo "    |  2. Monitor all system calls in real-time                                |"
        echo "    |  3. Save system call trace to a file                                     |"
        echo "    |  4. Trace system calls for a specific PID                                |"
        echo "    |  5. Search for a binary to trace                                         |"
        echo "    |  6. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                read -p "Enter the path to the binary to trace: " binary
                clear
                echo -e "${CYAN}Tracing system calls from $binary... (Press Ctrl+C to stop)${RESET}"
                sudo strace "$binary"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                read -p "Enter the path to the binary to monitor: " binary
                clear
                echo -e "${CYAN}Monitoring all system calls from $binary in real-time... (Press Ctrl+C to stop)${RESET}"
                sudo strace -f "$binary"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                read -p "Enter the path to the binary to trace: " binary
                read -p "Enter the file name to save the trace: " file
                clear
                echo -e "${CYAN}Saving system call trace to $file...${RESET}"
                sudo strace -o "$file" "$binary"
                echo "Trace saved to $file."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                read -p "Enter the PID of the process to trace: " pid
                clear
                echo -e "${CYAN}Tracing system calls for process with PID $pid... (Press Ctrl+C to stop)${RESET}"
                sudo strace -p "$pid"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                read -p "Enter the binary name to search: " binary_name
                clear
                echo -e "${CYAN}Searching for binary $binary_name in PATH...${RESET}"
                which "$binary_name"
                if [ $? -eq 0 ]; then
                    echo "Binary found at: $(which "$binary_name")"
                else
                    echo -e "${RED}Binary not found.${RESET}"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            6)
                echo "Returning to main menu..."
                break
                ;;
            *)
                echo -e "${RED}Invalid choice. Please try again.${RESET}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

trace_system_calls

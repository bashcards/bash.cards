#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

deep_process_analysis() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                      Jack of Clubs: Deep Process Analysis                 |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This card enables advanced process analysis on your system.               |"
    echo "    | Use the menu below to explore in-depth process details and behavior.      |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Trace system calls of a process                                       |"
    echo "    |  2. View process memory usage details                                     |"
    echo "    |  3. Analyze inter-process communication (IPC)                             |"
    echo "    |  4. Inspect threads of a specific process                                 |"
    echo "    |  5. Monitor real-time process behavior                                    |"
    echo "    |  6. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            read -p "Enter the PID of the process to trace system calls: " pid
            if [ -n "$pid" ] && [ "$pid" -eq "$pid" ] 2>/dev/null; then
                echo "Tracing system calls for PID: $pid. Press Ctrl+C to stop."
                strace -p "$pid" 2>&1 | less
            else
                echo "Invalid PID entered."
            fi
            ;;
        2)
            read -p "Enter the PID of the process to analyze memory usage: " pid
            if [ -n "$pid" ] && [ "$pid" -eq "$pid" ] 2>/dev/null; then
                echo "Displaying memory usage details for PID: $pid"
                cat /proc/"$pid"/status | grep -E 'Vm(Size|RSS|Peak):'
            else
                echo "Invalid PID entered."
            fi
            ;;
        3)
            echo "Analyzing inter-process communication..."
            echo "Shared memory segments, message queues, and semaphores in use:"
            ipcs | less
            ;;
        4)
            read -p "Enter the PID of the process to inspect threads: " pid
            if [ -n "$pid" ] && [ "$pid" -eq "$pid" ] 2>/dev/null; then
                echo "Inspecting threads of PID: $pid"
                ls /proc/"$pid"/task
            else
                echo "Invalid PID entered."
            fi
            ;;
        5)
            read -p "Enter the PID of the process to monitor in real-time: " pid
            if [ -n "$pid" ] && [ "$pid" -eq "$pid" ] 2>/dev/null; then
                echo "Monitoring real-time process behavior for PID: $pid"
                top -p "$pid"
            else
                echo "Invalid PID entered."
            fi
            ;;
        6)
            echo "Exiting Deep Process Analysis."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure necessary commands are available
for cmd in strace ipcs cat top ls; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required command '$cmd' is not available."
        exit 1
    fi
done

# Main script execution
deep_process_analysis
clear

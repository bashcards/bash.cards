#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

manage_baselines() {
    BASELINE_DIR="/var/baseline_configs"
    mkdir -p "$BASELINE_DIR"

    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |              Ten of Diamonds              |"
        echo "    |     Create and Manage System Baselines    |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Create a new baseline snapshot        |"
        echo "    |  2. Compare current state to baseline     |"
        echo "    |  3. List existing baselines               |"
        echo "    |  4. Delete a baseline                     |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
                SNAPSHOT_FILE="$BASELINE_DIR/baseline_$TIMESTAMP.txt"
                echo -e "${CYAN}Creating a new system baseline snapshot...${RESET}"
                echo -e "Baseline Snapshot - $TIMESTAMP\n" > "$SNAPSHOT_FILE"
                echo -e "System Info:" >> "$SNAPSHOT_FILE"
                uname -a >> "$SNAPSHOT_FILE"
                echo -e "\nInstalled Packages:" >> "$SNAPSHOT_FILE"
                dpkg -l >> "$SNAPSHOT_FILE" 2>/dev/null || rpm -qa >> "$SNAPSHOT_FILE"
                echo -e "\nNetwork Configuration:" >> "$SNAPSHOT_FILE"
                ifconfig >> "$SNAPSHOT_FILE" 2>/dev/null || ip addr show >> "$SNAPSHOT_FILE"
                echo -e "\nBaseline saved to $SNAPSHOT_FILE${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Comparing current state to an existing baseline...${RESET}"
                ls "$BASELINE_DIR"
                read -p "Enter the baseline filename to compare: " baseline_file
                if [[ -f "$BASELINE_DIR/$baseline_file" ]]; then
                    echo -e "${CYAN}Comparing current state with $baseline_file:${RESET}"
                    dpkg -l > /tmp/current_packages.txt 2>/dev/null || rpm -qa > /tmp/current_packages.txt
                    diff -u "$BASELINE_DIR/$baseline_file" /tmp/current_packages.txt | less
                else
                    echo -e "${CYAN}Baseline file not found.${RESET}"
                fi
                ;;
            3)
                clear
                echo -e "${CYAN}Listing existing baselines...${RESET}"
                ls "$BASELINE_DIR" || echo -e "${CYAN}No baselines found.${RESET}"
                ;;
            4)
                clear
                echo -e "${CYAN}Deleting a baseline...${RESET}"
                ls "$BASELINE_DIR"
                read -p "Enter the baseline filename to delete: " delete_file
                if [[ -f "$BASELINE_DIR/$delete_file" ]]; then
                    rm "$BASELINE_DIR/$delete_file"
                    echo -e "${CYAN}Baseline $delete_file deleted.${RESET}"
                else
                    echo -e "${CYAN}Baseline file not found.${RESET}"
                fi
                ;;
            5)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        echo -e "${CYAN}Press any key to return to the menu...${RESET}"
        read -n 1 -s -r
    done
}

manage_baselines

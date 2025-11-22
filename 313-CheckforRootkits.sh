#!/bin/bash

CYAN='\033[1;36m'
RED='\033[1;31m'
RESET='\033[0m'

check_for_rootkits() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                             Six of Spades                                |"
        echo "    |                        Check for Rootkits                                |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Run chkrootkit scan                                                  |"
        echo "    |  2. Install chkrootkit                                                   |"
        echo "    |  3. View chkrootkit logs                                                 |"
        echo "    |  4. Run advanced scans (rkhunter or ClamAV)                              |"
        echo "    |  5. Search system for hidden files                                       |"
        echo "    |  6. Review open ports and network connections                            |"
        echo "    |  7. View recent sudo usage                                               |"
        echo "    |  8. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Running chkrootkit scan...${RESET}"
                if command -v chkrootkit &> /dev/null; then
                    sudo chkrootkit | tee chkrootkit_results.log
                    echo "Scan completed. Results saved to chkrootkit_results.log."
                else
                    echo -e "${RED}chkrootkit is not installed. Please install it first.${RESET}"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Installing chkrootkit...${RESET}"
                if ! command -v chkrootkit &> /dev/null; then
                    sudo apt-get update && sudo apt-get install -y chkrootkit
                    if command -v chkrootkit &> /dev/null; then
                        echo "chkrootkit installed successfully."
                    else
                        echo -e "${RED}Failed to install chkrootkit. Please check your internet connection or package manager.${RESET}"
                    fi
                else
                    echo "chkrootkit is already installed."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Viewing chkrootkit logs...${RESET}"
                if [ -f chkrootkit_results.log ]; then
                    less chkrootkit_results.log
                else
                    echo -e "${RED}No chkrootkit logs found. Run a scan first.${RESET}"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Advanced scan options:${RESET}"
                echo "1. Run rkhunter (if installed)"
                echo "2. Run ClamAV (if installed)"
                echo "3. Return to previous menu"
                read -p "Enter your choice: " advanced_choice
                case $advanced_choice in
                    1)
                        if command -v rkhunter &> /dev/null; then
                            echo -e "${CYAN}Running rkhunter...${RESET}"
                            sudo rkhunter --check
                        else
                            echo -e "${RED}rkhunter is not installed. Install it using 'sudo apt-get install rkhunter'.${RESET}"
                        fi
                        ;;
                    2)
                        if command -v clamscan &> /dev/null; then
                            echo -e "${CYAN}Running ClamAV...${RESET}"
                            sudo clamscan -r /
                        else
                            echo -e "${RED}ClamAV is not installed. Install it using 'sudo apt-get install clamav'.${RESET}"
                        fi
                        ;;
                    3)
                        ;;
                    *)
                        echo -e "${RED}Invalid choice. Returning to main menu...${RESET}"
                        ;;
                esac
                read -n 1 -s -r -p "Press any key to return to the main menu..."
                ;;
            5)
                clear
                echo -e "${CYAN}Searching for hidden files...${RESET}"
                sudo find / -name ".*" -ls | tee hidden_files.log
                echo "Search completed. Results saved to hidden_files.log."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            6)
                clear
                echo -e "${CYAN}Reviewing open ports and network connections...${RESET}"
                sudo netstat -tuln | tee open_ports.log
                echo "Results saved to open_ports.log."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            7)
                clear
                echo -e "${CYAN}Viewing recent sudo usage...${RESET}"
                sudo grep 'COMMAND=' /var/log/auth.log | tail -20 | tee sudo_usage.log
                echo "Results saved to sudo_usage.log."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            8)
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

check_for_rootkits

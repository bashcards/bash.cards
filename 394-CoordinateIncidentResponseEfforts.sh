#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

coordinate_incident_response() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |               Five of Hearts              |"
        echo "    |    Coordinate Incident Response Efforts   |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. List active incident cases            |"
        echo "    |  2. Create a new incident case            |"
        echo "    |  3. Add details to an incident case       |"
        echo "    |  4. View incident case details            |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing active incident cases...${RESET}"
                if [ -d /tmp/thehive/cases ]; then
                    ls -1 /tmp/thehive/cases || echo -e "${CYAN}No cases found.${RESET}"
                else
                    echo -e "${CYAN}No cases directory found. Initializing...${RESET}"
                    mkdir -p /tmp/thehive/cases
                fi
                echo -e "${CYAN}Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            2)
                clear
                echo -e "${CYAN}Creating a new incident case...${RESET}"
                read -p "Enter case name: " case_name
                mkdir -p "/tmp/thehive/cases/$case_name" && echo -e "${CYAN}Case '$case_name' created successfully.${RESET}" || echo -e "${CYAN}Failed to create case.${RESET}"
                echo -e "${CYAN}Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            3)
                clear
                echo -e "${CYAN}Adding details to an incident case...${RESET}"
                if [ -d /tmp/thehive/cases ]; then
                    ls -1 /tmp/thehive/cases
                    read -p "Enter case name: " case_name
                    if [ -d "/tmp/thehive/cases/$case_name" ]; then
                        read -p "Enter details to add: " details
                        echo "$details" >> "/tmp/thehive/cases/$case_name/details.txt" && echo -e "${CYAN}Details added successfully.${RESET}" || echo -e "${CYAN}Failed to add details.${RESET}"
                    else
                        echo -e "${CYAN}Case '$case_name' does not exist.${RESET}"
                    fi
                else
                    echo -e "${CYAN}No cases directory found. Initialize cases first.${RESET}"
                fi
                echo -e "${CYAN}Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            4)
                clear
                echo -e "${CYAN}Viewing incident case details...${RESET}"
                if [ -d /tmp/thehive/cases ]; then
                    ls -1 /tmp/thehive/cases
                    read -p "Enter case name: " case_name
                    if [ -f "/tmp/thehive/cases/$case_name/details.txt" ]; then
                        cat "/tmp/thehive/cases/$case_name/details.txt" || echo -e "${CYAN}Failed to read case details.${RESET}"
                    else
                        echo -e "${CYAN}No details found for case '$case_name'.${RESET}"
                    fi
                else
                    echo -e "${CYAN}No cases directory found. Initialize cases first.${RESET}"
                fi
                echo -e "${CYAN}Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            5)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
    done
}

coordinate_incident_response

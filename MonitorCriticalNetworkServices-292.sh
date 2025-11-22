#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

monitor_services() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                                Queen of Hearts                           |"
        echo "    |                     Monitor Critical Network Services                    |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Check the status of critical services                                |"
        echo "    |  2. Monitor network services in real-time                                |"
        echo "    |  3. Restart a failed service                                             |"
        echo "    |  4. View active network connections                                      |"
        echo "    |  5. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Checking status of critical services...${RESET}"
                services=("ssh" "apache2" "nginx" "mysql" "postgresql")
                for service in "${services[@]}"; do
                    if systemctl list-units --full -all | grep -Fq "$service"; then
                        status=$(systemctl is-active "$service")
                        echo "$service: $status"
                    else
                        echo "$service: Not installed"
                    fi
                done
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Monitoring network services in real-time (Ctrl+C to stop):${RESET}"
                sudo journalctl -f -u ssh -u apache2 -u nginx -u mysql -u postgresql
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Restarting a failed service...${RESET}"
                read -p "Enter the name of the service to restart: " service_name
                if systemctl restart "$service_name" 2>/dev/null; then
                    echo "Service '$service_name' restarted successfully."
                else
                    echo "Failed to restart service '$service_name'. Check if it exists."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Viewing active network connections:${RESET}"
                sudo netstat -tulnp || sudo ss -tulnp
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
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

monitor_services

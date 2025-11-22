#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

team_server() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ____________________________________________"
        echo "    |               King of Spades               |"
        echo "    |    Centralize Red/Purple Team Operations   |"
        echo "    |____________________________________________|"
        echo "    |                                            |"
        echo "    |  1. Set up a centralized SSH bastion       |"
        echo "    |  2. Enable centralized logging with syslog |"
        echo "    |  3. Share files securely with SCP          |"
        echo "    |  4. Monitor team operations in real-time   |"
        echo "    |  5. Exit                                   |"
        echo "    |____________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Setting up a centralized SSH bastion...${RESET}"
                read -p "Enter username for SSH bastion: " bastion_user
                sudo useradd -m "$bastion_user"
                sudo passwd "$bastion_user"
                sudo bash -c "echo 'AllowUsers $bastion_user' >> /etc/ssh/sshd_config"
                sudo systemctl restart ssh
                echo -e "${CYAN}Centralized SSH bastion configured. User: $bastion_user${RESET}"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Enabling centralized logging with syslog...${RESET}"
                sudo bash -c 'echo "*.* @syslog-server.local:514" >> /etc/rsyslog.conf'
                sudo systemctl restart rsyslog
                echo -e "${CYAN}Centralized logging enabled to forward logs to syslog-server.local:514.${RESET}"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Sharing files securely with SCP...${RESET}"
                read -p "Enter file path to share: " file_path
                read -p "Enter target user@host: " target
                scp "$file_path" "$target:~/" && echo -e "${CYAN}File shared successfully!${RESET}" || echo -e "${CYAN}File sharing failed.${RESET}"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            4)
                clear
                echo -e "${CYAN}Monitoring team operations in real-time...${RESET}"
                sudo tail -f /var/log/auth.log
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
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

team_server

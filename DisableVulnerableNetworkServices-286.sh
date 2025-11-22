#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to disable vulnerable network services
disable_services() {
    while true; do
        clear
	echo -e "This Card Runs an the Super User(sudo)"
        echo -e "${CYAN}"
        echo "     _________________________________________________________________________"
        echo "    |                             Six of Hearts                               |"
        echo "    |                 Disable Vulnerable Network Services                     |"
        echo "    |_________________________________________________________________________|"
        echo "    |                                                                         |"
        echo "    | Choose a service to disable:                                            |"
        echo "    | 1. Disable FTP (vsftpd)                                                 |"
        echo "    | 2. Disable Telnet                                                       |"
        echo "    | 3. Disable Samba (SMB)                                                  |"
        echo "    | 4. Disable NFS (Network File System)                                    |"
        echo "    | 5. Disable HTTP (Apache/Nginx)                                          |"
        echo "    | 6. Return to main menu                                                  |"
        echo "    |_________________________________________________________________________|"
        echo "    |                                                                         |"
        echo "    |                            Enter your choice:                           |"
        echo "    |_________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                echo "Disabling FTP service..."
                sudo systemctl disable vsftpd && sudo systemctl stop vsftpd
                echo "FTP service has been disabled."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            2)
                echo "Disabling Telnet service..."
                sudo systemctl disable telnet && sudo systemctl stop telnet
                echo "Telnet service has been disabled."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            3)
                echo "Disabling Samba service..."
                sudo systemctl disable smbd && sudo systemctl stop smbd
                echo "Samba service has been disabled."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            4)
                echo "Disabling NFS service..."
                sudo systemctl disable nfs-server && sudo systemctl stop nfs-server
                echo "NFS service has been disabled."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            5)
                echo "Disabling HTTP services..."
                sudo systemctl disable apache2 && sudo systemctl stop apache2
                sudo systemctl disable nginx && sudo systemctl stop nginx
                echo "HTTP services have been disabled."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            6)
                break
                ;;
            *)
                echo "Invalid choice. Please select a valid option."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
        esac
    done
    clear
}

# Run the function for the card
disable_services

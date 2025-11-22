#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

deception_tech() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |              Queen of Spades             |"
        echo "    |   Deploy Decoys and Deceptive Artifacts  |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. Create Decoy User Accounts           |"
        echo "    |  2. Deploy Fake SSH Honeypot             |"
        echo "    |  3. Create Deceptive File Artifacts      |"
        echo "    |  4. Set Up Fake Open Ports               |"
        echo "    |  5. Create Fake Network Shares           |"
        echo "    |  6. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Creating Decoy User Accounts...${RESET}"
                read -p "Enter decoy username: " decoy_user
                sudo useradd -m "$decoy_user"
                sudo passwd -l "$decoy_user"
                echo -e "${CYAN}Decoy user $decoy_user created and locked.${RESET}"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Deploying Fake SSH Honeypot...${RESET}"
                sudo bash -c 'echo -e "#!/bin/bash\necho \"Fake SSH Access\"\nsleep 3\nexit" > /usr/local/bin/fake-ssh'
                sudo chmod +x /usr/local/bin/fake-ssh
                sudo bash -c 'echo -e "[Unit]\nDescription=Fake SSH Service\n\n[Service]\nExecStart=/usr/local/bin/fake-ssh\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/fake-ssh.service'
                sudo systemctl enable fake-ssh.service
                sudo systemctl start fake-ssh.service
                echo -e "${CYAN}Fake SSH honeypot deployed as a systemd service.${RESET}"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Creating Deceptive File Artifacts...${RESET}"
                echo "Generating fake sensitive files in /tmp..."
                sudo bash -c 'echo "Private Key" > /tmp/decoy_private_key'
                sudo bash -c 'echo "Password: hunter2" > /tmp/decoy_passwords.txt'
                chmod 600 /tmp/decoy_private_key /tmp/decoy_passwords.txt
                echo -e "${CYAN}Deceptive file artifacts created in /tmp.${RESET}"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            4)
                clear
                echo -e "${CYAN}Setting Up Fake Open Ports...${RESET}"
                read -p "Enter port number to simulate open: " fake_port
                sudo bash -c "echo 'nc -lk $fake_port -e /bin/bash' > /usr/local/bin/fake-port"
                sudo chmod +x /usr/local/bin/fake-port
                sudo bash -c 'echo -e "[Unit]\nDescription=Fake Open Port\n\n[Service]\nExecStart=/usr/local/bin/fake-port\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/fake-port.service'
                sudo systemctl enable fake-port.service
                sudo systemctl start fake-port.service
                echo -e "${CYAN}Fake open port service running on port $fake_port.${RESET}"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            5)
                clear
                echo -e "${CYAN}Creating Fake Network Shares...${RESET}"
                sudo mkdir -p /fake_share
                sudo bash -c 'echo "[fake_share]\npath = /fake_share\nread only = no\nbrowsable = yes\n" > /etc/samba/smb.conf'
                sudo service smbd restart
                echo -e "${CYAN}Fake network share created at /fake_share.${RESET}"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            6)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
    done
}

deception_tech

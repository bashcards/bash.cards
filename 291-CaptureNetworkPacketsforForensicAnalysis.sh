#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

capture_packets() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                                Jack of Hearts                            |"
        echo "    |             Capture Network Packets for Forensic Analysis                |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Capture packets with tcpdump                                         |"
        echo "    |  2. Save packets to a PCAP file                                          |"
        echo "    |  3. Filter packets by protocol or port                                   |"
        echo "    |  4. Analyze packets with Wireshark (Tshark)                              |"
        echo "    |  5. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Capturing packets in real-time with tcpdump (10 seconds):${RESET}"
                sudo tcpdump -nn -c 50 -i any || echo "Error capturing packets."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Saving packets to a PCAP file:${RESET}"
                read -p "Enter the output file name (e.g., capture.pcap): " filename
                sudo tcpdump -w "$filename" -i any || echo "Error saving packets."
                echo "Packets saved to $filename"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Filtering packets by protocol or port:${RESET}"
                read -p "Enter protocol or port to filter (e.g., tcp, udp, port 80): " filter
                sudo tcpdump -nn -c 50 -i any "$filter" || echo "Error capturing filtered packets."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Analyzing packets with Tshark:${RESET}"
                if command -v tshark &> /dev/null; then
                    sudo tshark -i any -c 50 || echo "Error analyzing packets."
                else
                    echo "Tshark is not installed. Please install it to use this option."
                fi
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

capture_packets

#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

network_segmentation() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |             Queen of Diamonds           |"
        echo "    |        Segment and Secure Networks      |"
        echo "    |_________________________________________|"
        echo "    |                                         |"
        echo "    |  1. Display current network interfaces  |"
        echo "    |  2. Create a new VLAN                   |"
        echo "    |  3. Assign an interface to a VLAN       |"
        echo "    |  4. Apply IP restrictions for a VLAN    |"
        echo "    |  5. Monitor network traffic per VLAN    |"
        echo "    |  6. Exit                                |"
        echo "    |_________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Displaying current network interfaces...${RESET}"
                ip link show || echo -e "${CYAN}Failed to retrieve interfaces.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Creating a new VLAN...${RESET}"
                read -p "Enter the parent interface (e.g., eth0): " parent_if
                read -p "Enter VLAN ID: " vlan_id
                ip link add link "$parent_if" name "$parent_if.$vlan_id" type vlan id "$vlan_id" && \
                ip link set dev "$parent_if.$vlan_id" up && \
                echo -e "${CYAN}VLAN $vlan_id created on $parent_if.${RESET}" || \
                echo -e "${CYAN}Failed to create VLAN.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Assigning an interface to a VLAN...${RESET}"
                read -p "Enter the VLAN interface (e.g., eth0.10): " vlan_if
                read -p "Enter the IP address for the VLAN (e.g., 192.168.1.1/24): " ip_addr
                ip addr add "$ip_addr" dev "$vlan_if" && \
                echo -e "${CYAN}IP $ip_addr assigned to $vlan_if.${RESET}" || \
                echo -e "${CYAN}Failed to assign IP.${RESET}"
                ;;
            4)
                clear
                echo -e "${CYAN}Applying IP restrictions for a VLAN...${RESET}"
                read -p "Enter the VLAN interface (e.g., eth0.10): " vlan_if
                read -p "Enter the IP to block (e.g., 192.168.1.100): " block_ip
                iptables -A INPUT -i "$vlan_if" -s "$block_ip" -j DROP && \
                echo -e "${CYAN}Blocked $block_ip on $vlan_if.${RESET}" || \
                echo -e "${CYAN}Failed to apply IP restriction.${RESET}"
                ;;
            5)
                clear
                echo -e "${CYAN}Monitoring network traffic per VLAN...${RESET}"
                read -p "Enter the VLAN interface to monitor (e.g., eth0.10): " vlan_if
                echo -e "${CYAN}Press Ctrl+C to stop monitoring.${RESET}"
                tcpdump -i "$vlan_if" || echo -e "${CYAN}Failed to monitor traffic.${RESET}"
                ;;
            6)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        echo -e "${CYAN}Press any key to return to the menu...${RESET}"
        read -n 1 -s -r
    done
}

network_segmentation

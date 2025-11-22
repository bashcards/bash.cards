#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

analyze_http_responses() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |            Eight of Hearts                |"
        echo "    |    Analyze HTTP Responses for Issues      |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Analyze HTTP headers for security     |"
        echo "    |  2. Test for directory traversal issues   |"
        echo "    |  3. Identify sensitive files              |"
        echo "    |  4. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Analyzing HTTP headers...${RESET}"
                read -p "Enter URL: " url
                curl -sI "$url" | grep -E "Server|Content-Type|Strict-Transport-Security|X-Frame-Options|X-XSS-Protection|X-Content-Type-Options"
                echo -e "${CYAN}Analysis complete.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Testing for directory traversal vulnerabilities...${RESET}"
                read -p "Enter URL: " url
                curl -s "$url/../../../../etc/passwd" | grep "root" && echo -e "${CYAN}Potential vulnerability found!${RESET}" || echo -e "${CYAN}No issues detected.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Checking for sensitive files...${RESET}"
                read -p "Enter URL: " url
                sensitive_files=("robots.txt" ".env" "config.json" ".git/config")
                for file in "${sensitive_files[@]}"; do
                    response=$(curl -s -o /dev/null -w "%{http_code}" "$url/$file")
                    if [ "$response" == "200" ]; then
                        echo -e "${CYAN}Sensitive file found: $file${RESET}"
                    fi
                done
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
        read -n 1 -s -r
    done
}

analyze_http_responses

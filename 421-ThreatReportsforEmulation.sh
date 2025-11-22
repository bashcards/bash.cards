#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

redcanary_threat_reports() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |              Four of Spades               |"
        echo "    |   Generate Threat Reports for Emulation   |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Fetch live threat reports             |"
        echo "    |  2. Generate summary from log files       |"
        echo "    |  3. Emulate a specific threat tactic      |"
        echo "    |  4. Export report to a file               |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Fetching live threat reports from Red Canary sources...${RESET}"
                echo "Scanning available logs for patterns of known threats..."
                grep -E "CVE|exploit|malware" /var/log/* 2>/dev/null | less || echo "No live threats found."
                ;;
            2)
                clear
                echo -e "${CYAN}Generating summary from log files...${RESET}"
                echo "Analyzing logs for anomalies:"
                awk '{print $1, $2, $NF}' /var/log/syslog | grep -i "error" || echo "No significant anomalies detected."
                ;;
            3)
                clear
                echo -e "${CYAN}Emulating a specific threat tactic...${RESET}"
                read -p "Enter a tactic to emulate (e.g., lateral movement, persistence): " tactic
                echo "Generating emulation tasks for tactic: $tactic"
                echo "Run 'taskset' and monitor system behavior."
                ;;
            4)
                clear
                echo -e "${CYAN}Exporting report to a file...${RESET}"
                report_file="threat_report_$(date +%F_%T).txt"
                echo "Threat report generated on $(date)" > "$report_file"
                echo "-----------------------------------" >> "$report_file"
                grep -E "CVE|exploit|malware" /var/log/* >> "$report_file" 2>/dev/null
                echo "Report saved as $report_file."
                ;;
            5)
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

redcanary_threat_reports

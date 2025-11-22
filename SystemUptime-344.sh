#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[32m'

# Menu for the Seven of Hearts Card
seven_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Seven of Hearts                             |"
    echo "     |                              System Uptime                               |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides advanced uptime analysis and system insights,        |"
    echo "     |  including user activity, process load, historical stats, and trends.    |"
    echo "     |                                                                          |"
    echo "     |  1. View Uptime and Load Averages                                        |"
    echo "     |  2. View User Login Sessions                                             |"
    echo "     |  3. View Top Processes by CPU/Memory Usage                               |"
    echo "     |  4. Monitor Live Uptime and System Load                                  |"
    echo "     |  5. View Historical Uptime Trends                                        |"
    echo "     |  6. Analyze Performance Over Time                                        |"
    echo "     |  7. Generate Uptime Summary Report                                       |"
    echo "     |  8. Export System Uptime Logs                                            |"
    echo "     |  9. Advanced Load Analysis                                               |"
    echo "     | 10. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_uptime ;;
        2) view_user_sessions ;;
        3) view_top_processes ;;
        4) monitor_live_stats ;;
        5) view_historical_uptime ;;
        6) analyze_performance ;;
        7) generate_summary ;;
        8) export_logs ;;
        9) advanced_load_analysis ;;
        10) exit 0 ;;
        *) echo -e "${GREEN}Invalid choice. Try again.${RESET}"; sleep 1; seven_of_hearts_menu ;;
    esac
}

# View uptime and load averages
view_uptime() {
    clear
    echo -e "${CYAN}System Uptime and Load Averages:${RESET}"
    uptime
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# View user login sessions
view_user_sessions() {
    clear
    echo -e "${CYAN}Current Logged-In Users:${RESET}"
    w
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# View top processes by CPU/memory usage
view_top_processes() {
    clear
    echo -e "${CYAN}Top CPU and Memory Consuming Processes:${RESET}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 20
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# Monitor live uptime and system load
monitor_live_stats() {
    clear
    echo -e "${CYAN}Monitoring Live Uptime and System Load. Press [CTRL+C] to stop.${RESET}"
    watch -n 2 uptime
    seven_of_hearts_menu
}

# View historical uptime trends
view_historical_uptime() {
    clear
    echo -e "${CYAN}System Uptime History (via system logs):${RESET}"
    last reboot | head -n 20
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# Analyze performance over time
analyze_performance() {
    clear
    echo -e "${CYAN}Analyzing System Performance Over Time:${RESET}"
    sar -u 1 10 2>/dev/null || echo "Install sysstat package to use sar."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# Generate uptime summary report
generate_summary() {
    clear
    echo -e "${CYAN}Generating Uptime Summary Report:${RESET}"
    report_file="uptime_summary_$(date +%Y%m%d%H%M%S).log"
    {
        echo "System Uptime Summary Report"
        echo "Generated on: $(date)"
        echo ""
        echo "Current Uptime and Load:"
        uptime
        echo ""
        echo "Top Processes (CPU/Memory):"
        ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 20
        echo ""
        echo "User Sessions:"
        w
    } >"$report_file"
    echo -e "Report saved to ${GREEN}$report_file${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# Export system uptime logs
export_logs() {
    clear
    echo -e "${CYAN}Exporting System Uptime Logs:${RESET}"
    log_file="uptime_logs_$(date +%Y%m%d%H%M%S).log"
    uptime >"$log_file"
    echo -e "Logs saved to ${GREEN}$log_file${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# Advanced load analysis
advanced_load_analysis() {
    clear
    echo -e "${CYAN}Advanced Load Analysis:${RESET}"
    echo "Analyzing CPU, Memory, and Disk I/O:"
    vmstat 1 10
    echo ""
    echo "Detailed CPU Usage:"
    mpstat -P ALL 1 5 2>/dev/null || echo "Install sysstat package to use mpstat."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

seven_of_hearts_menu

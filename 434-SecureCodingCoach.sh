[200~#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

secure_coding_practices() {
    clear
    echo -e "${CYAN}"
    echo "     _________________________________________"
    echo "    |             Four of Clubs               |"
    echo "    |    Educate on Secure Coding Practice    |"
    echo "    |_________________________________________|"
    echo -e "${RESET}"

    while true; do
        clear
        echo -e "${CYAN}Select a secure coding topic to learn:${RESET}"
        echo "1. Input Validation"
        echo "2. Secure Authentication"
        echo "3. Error Handling"
        echo "4. Safe Memory Management"
        echo "5. Exit"
        read -p "Choice: " choice

        case $choice in
            1)
                clear
                echo -e "${CYAN}Topic: Input Validation${RESET}"
                echo "Input validation ensures that user inputs are checked for correctness before processing."
                echo "Best Practices:"
                echo "1. Sanitize inputs to remove unwanted characters."
                echo "2. Use allow-lists for accepted input formats."
                echo "3. Avoid using unvalidated input in SQL queries (to prevent SQL injection)."
                echo -e "\nPress any key to return to the menu."
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Topic: Secure Authentication${RESET}"
                echo "Authentication involves verifying user identity securely."
                echo "Best Practices:"
                echo "1. Use strong password policies."
                echo "2. Store passwords using secure hash algorithms (e.g., bcrypt)."
                echo "3. Implement multi-factor authentication (MFA) where possible."
                echo -e "\nPress any key to return to the menu."
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Topic: Error Handling${RESET}"
                echo "Error handling ensures that application errors are managed securely."
                echo "Best Practices:"
                echo "1. Do not expose sensitive error information to users."
                echo "2. Log errors securely for troubleshooting."
                echo "3. Use custom error messages to guide users without revealing internal details."
                echo -e "\nPress any key to return to the menu."
                read -n 1 -s
                ;;
            4)
                clear
                echo -e "${CYAN}Topic: Safe Memory Management${RESET}"
                echo "Memory management involves handling application memory securely and efficiently."
                echo "Best Practices:"
                echo "1. Use modern programming languages with built-in memory safety (e.g., Rust)."
                echo "2. Avoid buffer overflows by checking array bounds."
                echo "3. Free allocated memory to prevent memory leaks."
                echo -e "\nPress any key to return to the menu."
                read -n 1 -s
                ;;
            5)
                echo -e "${CYAN}Exiting Secure Coding Practices...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Please try again.${RESET}"
                ;;
        esac
    done
}

secure_coding_practices

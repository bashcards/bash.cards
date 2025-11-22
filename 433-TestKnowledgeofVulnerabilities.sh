#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

vulnerability_quiz() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________"
    echo "    |              Three of Clubs               |"
    echo "    |  Test Knowledge of System Vulnerabilities |"
    echo "    |___________________________________________|"
    echo -e "${RESET}"

    score=0
    total_questions=3

    questions=(
        "Which command checks for SUID binaries on a Linux system?"
        "Which protocol is commonly exploited due to lack of encryption in older versions?"
        "What type of attack attempts to guess passwords using a dictionary of words?"
    )

    options=(
        "1. lsattr  2. find  3. chattr  4. grep"
        "1. HTTPS  2. SSH  3. FTP  4. RDP"
        "1. Brute-force  2. Dictionary  3. Rainbow Table  4. Phishing"
    )

    answers=(2 3 2)

    for i in ${!questions[@]}; do
        echo -e "${CYAN}Question $((i + 1)):${RESET} ${questions[i]}"
        echo -e "${CYAN}Options:${RESET} ${options[i]}"
        read -p "Your Answer (1-4): " user_answer

        if [[ $user_answer -eq ${answers[i]} ]]; then
            echo -e "${CYAN}Correct!${RESET}"
            ((score++))
        else
            echo -e "${CYAN}Wrong! The correct answer was ${answers[i]}.${RESET}"
        fi

        echo -e "${CYAN}Press any key to continue to the next question...${RESET}"
        read -n 1 -s -r
        clear
    done

    echo -e "${CYAN}Quiz Complete!${RESET}"
    echo -e "${CYAN}Your Score: $score / $total_questions${RESET}"
    if [[ $score -eq $total_questions ]]; then
        echo -e "${CYAN}Excellent! You're a vulnerability expert.${RESET}"
    elif [[ $score -ge 2 ]]; then
        echo -e "${CYAN}Good job! Keep studying to master vulnerabilities.${RESET}"
    else
        echo -e "${CYAN}Keep practicing to improve your knowledge.${RESET}"
    fi

    echo -e "${CYAN}Press any key to return to the main menu...${RESET}"
    read -n 1 -s -r
}

vulnerability_quiz

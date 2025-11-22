#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

phishing_simulation() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |               Two of Clubs              |"
        echo "    |    Conduct Phishing Simulation Tests    |"
        echo "    |_________________________________________|"
        echo "    |                                         |"
        echo "    |  1. Create a phishing simulation email  |"
        echo "    |  2. Simulate phishing website           |"
        echo "    |  3. Generate fake login credentials     |"
        echo "    |  4. Test phishing awareness             |"
        echo "    |  5. Monitor suspicious connections      |"
        echo "    |  6. Exit                                |"
        echo "    |_________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Creating a phishing simulation email...${RESET}"
                read -p "Enter recipient email: " recipient
                read -p "Enter subject line: " subject
                echo -e "This is a phishing simulation email.\nPlease do not click suspicious links." | \
                mail -s "$subject" "$recipient" && \
                echo -e "${CYAN}Phishing email sent to $recipient.${RESET}" || \
                echo -e "${CYAN}Failed to send phishing email. Check mail configuration.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Setting up a simulated phishing website...${RESET}"
                echo "Enter the directory where you want to create the phishing simulation site:"
                read -p "Directory (e.g., /var/www/html): " site_dir
                mkdir -p "$site_dir"
                cat > "$site_dir/index.html" <<EOF
<html>
<head><title>Phishing Simulation</title></head>
<body>
<h1>Login Here</h1>
<form method="POST" action="capture.php">
    <input type="text" name="username" placeholder="Username"><br>
    <input type="password" name="password" placeholder="Password"><br>
    <input type="submit" value="Login">
</form>
</body>
</html>
EOF
                cat > "$site_dir/capture.php" <<EOF
<?php
\$file = fopen("captured_credentials.txt", "a");
fwrite(\$file, "Username: " . \$_POST['username'] . " Password: " . \$_POST['password'] . "\\n");
fclose(\$file);
?>
EOF
                echo -e "${CYAN}Phishing simulation site created at $site_dir. Serve it using a web server.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Generating fake login credentials...${RESET}"
                for i in {1..5}; do
                    echo "Username: user$i, Password: pass$i" >> fake_credentials.txt
                done
                echo -e "${CYAN}Fake credentials generated in 'fake_credentials.txt'.${RESET}"
                ;;
            4)
                clear
                echo -e "${CYAN}Testing phishing awareness...${RESET}"
                echo "Simulating phishing awareness by sending a questionnaire to the user."
                read -p "Enter email for phishing awareness test: " email
                echo -e "This is a simulated phishing awareness test.\nPlease review the attached questionnaire." | \
                mail -s "Phishing Awareness Test" "$email" && \
                echo -e "${CYAN}Phishing awareness test sent to $email.${RESET}" || \
                echo -e "${CYAN}Failed to send phishing awareness test.${RESET}"
                ;;
            5)
                clear
                echo -e "${CYAN}Monitoring for suspicious connections...${RESET}"
                echo -e "Press Ctrl+C to stop monitoring.\n"
                netstat -tunp | grep "ESTABLISHED" | grep -i "http" | tee suspicious_connections.log
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

phishing_simulation

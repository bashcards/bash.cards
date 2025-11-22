#!/bin/bash

declare -A ports=(
    [20]="FTP Data Transfer"
    [21]="FTP Control"
    [22]="SSH"
    [23]="Telnet"
    [25]="SMTP"
    [53]="DNS"
    [80]="HTTP"
    [110]="POP3"
    [143]="IMAP"
    [443]="HTTPS"
    [465]="SMTPS"
    [587]="SMTP"
    [993]="IMAPS"
    [995]="POP3S"
)

while true; do
    clear
    echo "Network Monitoring and Diagnostics"
    echo "=================================="
    for port in "${!ports[@]}"; do
        echo -n "${ports[$port]} (port $port): "
        nc -z -v -w5 localhost $port &> /dev/null
        if [ $? -eq 0 ]; then
            echo "Open"
        else
            echo "Closed"
        fi
    done
    sleep 5
done

#!/bin/bash
CYAN='\033[1;36m'; RESET='\033[0m'; log(){ echo "$(date '+%F %T') - $1" >> /var/log/password_management.log; }
while true; do clear; echo -e "${CYAN} - Password Management${RESET}
1) Change Own Password  2) Change User Password  3) Force Password Change
4) Set Expiration      5) Lock Password        6) Unlock Password
7) Audit Settings      8) Batch Operations     9) Exit"; read -p "Choice: " c
case "$c" in
1) passwd; read -n1 -s -r -p "Press any key...";;
2) read -p "Username: " u; id "$u" &>/dev/null && passwd "$u" && log "Changed password for $u" || echo "User not found."; read -n1 -s -r -p "Press any key...";;
3) read -p "Username: " u; id "$u" &>/dev/null && chage -d 0 "$u" && log "Forced password change for $u" || echo "User not found."; read -n1 -s -r -p "Press any key...";;
4) read -p "Username: " u; if id "$u" &>/dev/null; then read -p "Max Days: " m; read -p "Min Days: " n; read -p "Warn Days: " w; chage -M "$m" -m "$n" -W "$w" "$u" && log "Set password expiry for $u"; else echo "User not found."; fi; read -n1 -s -r -p "Press any key...";;
5) read -p "Username: " u; id "$u" &>/dev/null && passwd -l "$u" && log "Locked password for $u" || echo "User not found."; read -n1 -s -r -p "Press any key...";;
6) read -p "Username: " u; id "$u" &>/dev/null && passwd -u "$u" && log "Unlocked password for $u" || echo "User not found."; read -n1 -s -r -p "Press any key...";;
7) read -p "Username: " u; id "$u" &>/dev/null && chage -l "$u" && log "Audited password for $u" || echo "User not found."; read -n1 -s -r -p "Press any key...";;
8) read -p "Usernames (space-separated): " -a users; echo "1) Change  2) Force Change  3) Lock  4) Unlock"; read -p "Operation: " op; for u in "${users[@]}"; do if id "$u" &>/dev/null; then case "$op" in 1) passwd "$u";; 2) chage -d 0 "$u";; 3) passwd -l "$u";; 4) passwd -u "$u";; *) echo "Invalid op for $u";; esac; log "Batch op $op on $u"; else echo "User $u not found."; fi; done; read -n1 -s -r -p "Press any key...";;
9) exit;;
*) :;;
esac; done

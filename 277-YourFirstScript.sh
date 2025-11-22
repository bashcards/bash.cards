#!/bin/bash

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
TITLE="Your First Script"
MENU="Choose one of the following options:"

OPTIONS=(1 "Create new file"
         2 "Edit with nano"
         3 "Edit with vim"
         4 "Exit")

while true; do
  CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)

  clear
  case $CHOICE in
    1)
      read -p "Enter filename: " filename
      touch $filename
      chmod +x $filename
      ;;
    2)
      read -p "Enter filename: " filename
      nano $filename
      ;;
    3)
      read -p "Enter filename: " filename
      vim $filename
      ;;
    4)
      exit
      ;;
  esac
done

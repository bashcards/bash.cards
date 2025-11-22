#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Six of Clubs Card
six_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Six of Clubs                               |"
    echo "     |                  Boot into a Privacy-Focused Operating System           |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides options to download, create, and boot into Tails,   |"
    echo "     |  a live operating system designed for privacy and anonymity.            |"
    echo "     |                                                                         |"
    echo "     |  1. Download Tails ISO                                                  |"
    echo "     |  2. Create a Tails Bootable USB                                         |"
    echo "     |  3. Boot into Tails                                                     |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) download_tails ;;
        2) create_bootable_usb ;;
        3) boot_tails ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; six_of_clubs_menu ;;
    esac
}

# Download Tails ISO
download_tails() {
    clear
    echo -e "${CYAN}Downloading Tails ISO...${RESET}"
    if command -v curl &>/dev/null; then
        curl -O https://tails.boum.org/install/download/
        echo "Tails ISO downloaded successfully to the current directory."
    else
        echo "Error: curl is not installed. Please install it and try again."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_clubs_menu
}

# Create a Tails Bootable USB
create_bootable_usb() {
    clear
    echo -e "${CYAN}Creating a Tails Bootable USB...${RESET}"
    if command -v dd &>/dev/null; then
        echo "Please specify the path to the Tails ISO file:"
        read -p "Tails ISO Path: " iso_path
        echo "Please specify the USB device (e.g., /dev/sdX):"
        read -p "USB Device: " usb_device

        echo "WARNING: This will erase all data on $usb_device!"
        read -p "Type 'yes' to proceed: " confirmation
        if [[ "$confirmation" == "yes" ]]; then
            sudo dd if="$iso_path" of="$usb_device" bs=4M status=progress && sync
            echo "Tails Bootable USB created successfully."
        else
            echo "Operation canceled."
        fi
    else
        echo "Error: dd is not installed. Please install it and try again."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_clubs_menu
}

# Boot into Tails
boot_tails() {
    clear
    echo -e "${CYAN}Booting into Tails...${RESET}"
    echo "Please reboot your system and boot from the Tails USB you created."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_clubs_menu
}

six_of_clubs_menu

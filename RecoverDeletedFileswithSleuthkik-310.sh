#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

recover_deleted_files() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     _________________________________________________________________________"
        echo "    |                              Three of Spades                            |"
        echo "    |                    Recover Deleted Files with Sleuthkit                 |"
        echo "    |_________________________________________________________________________|"
        echo "    |                                                                         |"
        echo "    |  Options:                                                               |"
        echo "    |  1. Search for deleted files in a disk image                            |"
        echo "    |  2. Recover a specific deleted file                                     |"
        echo "    |  3. Install required tools (if not installed)                           |"
        echo "    |  4. Return to main menu                                                 |"
        echo "    |_________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Searching for deleted files...${RESET}"
                read -p "Enter the path to the disk image or device (e.g., /dev/sdX): " disk_image
                if [ -f "$disk_image" ] || [ -b "$disk_image" ]; then
                    echo "Using 'fls' to list deleted files:"
                    fls -r "$disk_image" | grep -i "deleted"
                else
                    echo "Invalid disk image or device: $disk_image"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Recovering a specific deleted file...${RESET}"
                read -p "Enter the path to the disk image or device (e.g., /dev/sdX): " disk_image
                if [ -f "$disk_image" ] || [ -b "$disk_image" ]; then
                    read -p "Enter the metadata address of the file to recover: " meta_addr
                    read -p "Enter the output directory: " output_dir
                    mkdir -p "$output_dir"
                    echo "Recovering the file using 'icat'..."
                    icat "$disk_image" "$meta_addr" > "$output_dir/recovered_file"
                    echo "File recovered to $output_dir/recovered_file"
                else
                    echo "Invalid disk image or device: $disk_image"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Installing required tools...${RESET}"
                if ! command -v fls &> /dev/null || ! command -v icat &> /dev/null; then
                    echo "Sleuthkit tools are not installed. Installing sleuthkit..."
                    sudo apt-get update && sudo apt-get install -y sleuthkit
                else
                    echo "Sleuthkit tools are already installed."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                echo "Returning to main menu..."
                break
                ;;
            *)
                echo "Invalid choice. Please try again."
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

recover_deleted_files

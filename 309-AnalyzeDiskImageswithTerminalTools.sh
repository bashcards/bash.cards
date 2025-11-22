#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

analyze_disk_images() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                               Two of Spades                              |"
        echo "    |                      Analyze Disk Images with Terminal Tools             |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. List files in a disk image                                           |"
        echo "    |  2. View details of a specific file in a disk image                      |"
        echo "    |  3. Extract a file from a disk image                                     |"
        echo "    |  4. Install required tools (if not installed)                            |"
        echo "    |  5. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing files in a disk image...${RESET}"
                read -p "Enter the path to the disk image: " image_path
                if [ -f "$image_path" ]; then
                    echo "Using 'fls' to list files in the disk image:"
                    fls "$image_path"
                else
                    echo "Disk image not found: $image_path"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Viewing details of a specific file...${RESET}"
                read -p "Enter the path to the disk image: " image_path
                if [ -f "$image_path" ]; then
                    read -p "Enter the metadata address of the file: " meta_addr
                    echo "Using 'istat' to view file details:"
                    istat "$image_path" "$meta_addr"
                else
                    echo "Disk image not found: $image_path"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Extracting a file from a disk image...${RESET}"
                read -p "Enter the path to the disk image: " image_path
                if [ -f "$image_path" ]; then
                    read -p "Enter the metadata address of the file: " meta_addr
                    read -p "Enter the output directory: " output_dir
                    echo "Extracting the file using 'icat'..."
                    icat "$image_path" "$meta_addr" > "$output_dir/extracted_file"
                    echo "File extracted to $output_dir/extracted_file"
                else
                    echo "Disk image not found: $image_path"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Installing required tools...${RESET}"
                if ! command -v fls &> /dev/null || ! command -v istat &> /dev/null || ! command -v icat &> /dev/null; then
                    echo "Sleuthkit tools are not installed. Installing sleuthkit..."
                    sudo apt-get update && sudo apt-get install -y sleuthkit
                else
                    echo "Sleuthkit tools are already installed."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
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

analyze_disk_images

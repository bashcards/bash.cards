#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
LOGFILE="./foremost_recovery.log"

log_action() {
    echo "$(date): $1" >> "$LOGFILE"
}

carve_files() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                                Four of Spades                            |"
        echo "    |                         Carve Files from Raw Disk Data                   |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Perform file carving on a disk image                                 |"
        echo "    |  2. Preview disk image content                                           |"
        echo "    |  3. Specify file types to recover                                        |"
        echo "    |  4. Verify recovered files integrity                                     |"
        echo "    |  5. Install required tools (if not installed)                            |"
        echo "    |  6. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Performing file carving...${RESET}"
                read -p "Enter the path to the disk image or device (e.g., /dev/sdX or /path/to/image): " disk_image
                if [ -f "$disk_image" ] || [ -b "$disk_image" ]; then
                    read -p "Enter the output directory (default: ./output): " output_dir
                    output_dir=${output_dir:-./output}
                    mkdir -p "$output_dir"
                    echo "Running 'foremost' on $disk_image..."
                    sudo foremost -i "$disk_image" -o "$output_dir" && log_action "Carved files from $disk_image into $output_dir"
                    echo "File carving completed. Recovered files saved in $output_dir."
                else
                    echo "Invalid disk image or device: $disk_image"
                    log_action "Failed to carve files: Invalid disk image $disk_image"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Previewing disk image content...${RESET}"
                read -p "Enter the path to the disk image or device (e.g., /dev/sdX or /path/to/image): " disk_image
                if [ -f "$disk_image" ]; then
                    echo "Displaying disk image content summary:"
                    sudo file "$disk_image"
                    log_action "Previewed content of $disk_image"
                else
                    echo "Invalid disk image or device: $disk_image"
                    log_action "Failed to preview content: Invalid disk image $disk_image"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Specify file types to recover...${RESET}"
                echo "Supported file types: jpg, png, pdf, doc, mp3, mp4, etc."
                read -p "Enter file types to recover (comma-separated, e.g., jpg,pdf): " file_types
                read -p "Enter the path to the disk image or device (e.g., /dev/sdX or /path/to/image): " disk_image
                read -p "Enter the output directory (default: ./output): " output_dir
                output_dir=${output_dir:-./output}
                mkdir -p "$output_dir"
                echo "Running 'foremost' on $disk_image for file types: $file_types..."
                sudo foremost -i "$disk_image" -o "$output_dir" -t "$file_types" && log_action "Recovered file types ($file_types) from $disk_image into $output_dir"
                echo "File carving completed. Recovered files saved in $output_dir."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Verifying output integrity...${RESET}"
                read -p "Enter the output directory to verify (default: ./output): " output_dir
                output_dir=${output_dir:-./output}
                if [ -d "$output_dir" ]; then
                    echo "Generating checksums for files in $output_dir..."
                    find "$output_dir" -type f -exec sha256sum {} \; > "$output_dir/checksums.sha256"
                    echo "Checksums generated. Saved to $output_dir/checksums.sha256."
                    log_action "Verified integrity of files in $output_dir"
                else
                    echo "Output directory not found: $output_dir"
                    log_action "Failed to verify integrity: Output directory $output_dir not found"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                clear
                echo -e "${CYAN}Installing required tools...${RESET}"
                if ! command -v foremost &> /dev/null; then
                    echo "Foremost is not installed. Installing..."
                    sudo apt-get update && sudo apt-get install -y foremost
                else
                    echo "Foremost is already installed."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            6)
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

carve_files

#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Six of Hearts Card
six_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Six of Hearts                              |"
    echo "     |                  Extract Metadata from Public Documents                 |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides a lightweight interface for extracting metadata     |"
    echo "     |  from publicly available documents using metagoofil.                    |"
    echo "     |                                                                         |"
    echo "     |                                                                         |"
    echo "     |  1. Extract metadata from a domain                                      |"
    echo "     |  2. View extracted metadata                                             |"
    echo "     |  3. Save metadata results to a file                                     |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) extract_metadata ;;
        2) view_metadata ;;
        3) save_metadata ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; six_of_hearts_menu ;;
    esac
}

# Extract metadata from a domain
extract_metadata() {
    clear
    echo -e "${CYAN}Starting metadata extraction...${RESET}"
    if command -v metagoofil &>/dev/null; then
        read -p "Enter the target domain (e.g., example.com): " domain
        read -p "Enter the output directory (e.g., ./metagoofil_output): " output_dir
        metagoofil -d "$domain" -o "$output_dir" -t pdf,doc,xls,ppt
        echo -e "${CYAN}Metadata extraction completed. Results saved in $output_dir.${RESET}"
    else
        echo -e "${CYAN}Error: metagoofil is not installed.${RESET}"
        echo "Please install metagoofil using your package manager or visit https://www.edge-security.com/metagoofil.php."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

# View extracted metadata
view_metadata() {
    clear
    echo -e "${CYAN}Viewing extracted metadata...${RESET}"
    read -p "Enter the directory containing the metadata files: " metadata_dir
    if [[ -d "$metadata_dir" ]]; then
        ls "$metadata_dir"
        read -p "Enter the filename to view: " filename
        if [[ -f "$metadata_dir/$filename" ]]; then
            less "$metadata_dir/$filename"
        else
            echo -e "${CYAN}Error: File $filename not found in $metadata_dir.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: Directory $metadata_dir not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

# Save metadata results to a file
save_metadata() {
    clear
    echo -e "${CYAN}Saving metadata results...${RESET}"
    read -p "Enter the directory containing the metadata files: " metadata_dir
    read -p "Enter the filename to save results (e.g., metadata_results.txt): " output_file
    if [[ -d "$metadata_dir" ]]; then
        cat "$metadata_dir"/* > "$output_file"
        echo -e "${CYAN}Metadata results saved to $output_file.${RESET}"
    else
        echo -e "${CYAN}Error: Directory $metadata_dir not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

six_of_hearts_menu

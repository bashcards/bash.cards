#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

UNDO_FILE="/tmp/four_of_spades_undo.log"

# Menu for the Four of Spades Card
four_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Four of Spades                             |"
    echo "     |                          Move or Rename Enhanced                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides an advanced interface to move or rename             |"
    echo "     |  files and directories with additional features.                        |"
    echo "     |                                                                         |"
    echo "     |  1. Move Files or Directories                                           |"
    echo "     |  2. Rename Files or Directories                                         |"
    echo "     |  3. Undo Last Operation                                                 |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) move_files_or_directories ;;
        2) rename_files_or_directories ;;
        3) undo_last_operation ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; four_of_spades_menu ;;
    esac
}

# Option 1: Move Files or Directories
move_files_or_directories() {
    clear
    echo -e "${CYAN}Move Files or Directories${RESET}"
    read -p "Enter source paths (space-separated): " -a src_paths
    read -p "Enter the destination directory: " dest_dir

    if [[ ! -d $dest_dir ]]; then
        echo -e "${RED}Error: Destination directory does not exist.${RESET}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
        four_of_spades_menu
    fi

    for src in "${src_paths[@]}"; do
        if [[ -e $src ]]; then
            mv "$src" "$dest_dir" && echo "$src -> $dest_dir" >> "$UNDO_FILE"
            echo -e "${GREEN}Moved $src to $dest_dir.${RESET}"
        else
            echo -e "${RED}Error: Source $src does not exist.${RESET}"
        fi
    done

    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_spades_menu
}

# Option 2: Rename Files or Directories
rename_files_or_directories() {
    clear
    echo -e "${CYAN}Rename Files or Directories${RESET}"
    echo "1. Rename a single file or directory"
    echo "2. Batch rename using a pattern"
    read -p "Choose an option: " rename_choice

    case $rename_choice in
        1)
            read -p "Enter the current name or path: " current_name
            if [[ -e $current_name ]]; then
                read -p "Enter the new name: " new_name
                mv "$current_name" "$new_name" && echo "$new_name -> $current_name" >> "$UNDO_FILE"
                echo -e "${GREEN}Renamed to $new_name.${RESET}"
            else
                echo -e "${RED}Error: $current_name does not exist.${RESET}"
            fi
            ;;
        2)
            read -p "Enter the directory containing files to rename: " dir
            if [[ ! -d $dir ]]; then
                echo -e "${RED}Error: Directory does not exist.${RESET}"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                four_of_spades_menu
            fi

            read -p "Enter the pattern to match (e.g., '*.txt'): " pattern
            read -p "Enter the new name template (e.g., 'file_#.txt', where # is replaced by a number): " template

            files=("$dir"/$pattern)
            if [[ ${#files[@]} -eq 0 ]]; then
                echo -e "${RED}Error: No files matching the pattern found.${RESET}"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                four_of_spades_menu
            fi

            count=1
            for file in "${files[@]}"; do
                new_name="${template//#/$count}"
                mv "$file" "$dir/$new_name" && echo "$dir/$new_name -> $file" >> "$UNDO_FILE"
                echo -e "${GREEN}Renamed $file to $new_name.${RESET}"
                ((count++))
            done
            ;;
        *)
            echo "Invalid choice. Returning to the menu."
            ;;
    esac

    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_spades_menu
}

# Option 3: Undo Last Operation
undo_last_operation() {
    clear
    if [[ ! -f $UNDO_FILE || ! -s $UNDO_FILE ]]; then
        echo -e "${RED}No operations to undo.${RESET}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
        four_of_spades_menu
    fi

    tail -1 "$UNDO_FILE" | while read -r undo; do
        src=$(echo "$undo" | awk -F' -> ' '{print $1}')
        dest=$(echo "$undo" | awk -F' -> ' '{print $2}')
        if [[ -e $src ]]; then
            mv "$src" "$dest"
            echo -e "${GREEN}Undone: $src -> $dest.${RESET}"
        else
            echo -e "${RED}Error: Cannot undo $src. File or directory not found.${RESET}"
        fi
    done

    sed -i '$ d' "$UNDO_FILE" # Remove the last operation
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_spades_menu
}

four_of_spades_menu

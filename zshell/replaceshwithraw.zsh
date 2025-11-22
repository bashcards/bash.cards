x#!/bin/zsh

# Iterate over all .raw files
for rawfile in *.raw; do
  [[ -f "$rawfile" ]] || continue

  # Derive the original .sh filename
  shfile="${rawfile%.raw}.sh"

  if [[ -f "$shfile" ]]; then
    echo "Replacing $shfile with contents of $rawfile"

    # Overwrite the .sh file with the .raw content
    cp "$rawfile" "$shfile"

    # Make sure it's executable
    chmod +x "$shfile"
  else
    echo "No matching .sh file for $rawfile, skipped"
  fi
done


#!/bin/zsh

# Iterate over all .sh files with a dash in the filename
for file in *-*.sh; do
  [[ -f "$file" ]] || continue

  # Look for a line containing "gunzip"
  if grep -q "gunzip" "$file"; then
    # Extract the base64 string after 'echo' up to the first pipe
    base64str=$(grep "gunzip" "$file" | sed -n 's/.*echo \([^|]*\).*/\1/p')

    if [[ -n "$base64str" ]]; then
      rawfile="${file%.sh}.raw"

      # Decode and gunzip the base64 string into the .raw file
      echo "$base64str" | base64 -d | gunzip > "$rawfile"

      echo "Created raw file: $rawfile"
    else
      echo "Found gunzip in $file but could not extract base64 string"
    fi
  else
    echo "Skipped $file (no gunzip found)"
  fi
done


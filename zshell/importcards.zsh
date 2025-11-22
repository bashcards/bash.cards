#!/bin/zsh

resp=$(curl -s https://bash.cards/ipa/get/import2.php)

echo "$resp" | jq -c '.[] | select(.bashscript != null and .bashscript != "")' | while read -r item; do
  id=$(echo "$item" | jq -r '.id')
  title=$(echo "$item" | jq -r '.title')
  script_b64=$(echo "$item" | jq -r '.bashscript')

  # Decode Base64 back to original script
  script=$(echo "$script_b64" | base64 --decode)

  safe_title=$(echo "$title" | tr -cd '[:alnum:]')
  filename="${safe_title}-${id}.sh"

  printf "%s\n" "$script" > "$filename"
  chmod +x "$filename"
  echo "Created $filename"
done


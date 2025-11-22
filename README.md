# Bash Cards – QR Executed Bash Scripts

Bash Cards is a hands-free, file-less automation system where each physical card contains a QR-encoded Bash script.
Scanning a card injects and executes the script directly into a live shell, without creating files or requiring chmod.

This document contains the full README and the full Raw Execution Engine documentation.

-------------------------------------------------------------------------------

README

What Are Bash Cards?

Bash Cards are physical or digital cards that contain a compressed, base64-encoded Bash program inside a QR code.
Scanning the card executes the restored script instantly inside the terminal.

A card can:
• Launch tools
• Configure systems
• Display menus
• Chain to other cards
• Automate workflows

Everything runs only in memory.

-------------------------------------------------------------------------------

How Cards Execute

The core execution wrapper:

bash -c "$(echo H4sIAAAAAAAA... | base64 -d | gunzip)"

Execution pipeline:
1. Scanner types the base64 payload
2. base64 -d decodes
3. gunzip restores the original script
4. bash -c executes it immediately

No chmod, no file, no disk write.

-------------------------------------------------------------------------------

Why Bash Cards Exist

Built for environments where keyboards are not usable:
• Space operations
• Industrial kiosks
• Labs and training
• Field devices
• Locked-down terminals
• Air-gapped systems

Hands-free, modular, deterministic automation.

-------------------------------------------------------------------------------

Creating Your Own Card

Step 1: Write the script
Keep menus simple, finite, numeric, and q-driven.

Step 2: Encode
gzip -c script.sh | base64 -w0

Step 3: Wrap
bash -c "$(echo <payload> | base64 -d | gunzip)"

This line becomes the QR.

-------------------------------------------------------------------------------

Card Architecture

A typical card:
• Frames the terminal
• Provides a compact menu (1,2,q)
• Executes one focused function
• Optionally chains to another card

-------------------------------------------------------------------------------

Security Model

Scripts run with the user's permission.

To inspect a card payload:
echo <payload> | base64 -d | gunzip > inspect.sh

Review for destructive commands.

-------------------------------------------------------------------------------

Example Card Flow

Scan “System Info”
→ Menu
→ Pick 1
→ Script prints uptime, memory, disks
→ Returns to menu
→ Scan next card

Cards compose workflows.

-------------------------------------------------------------------------------

Why The System Works

A QR scanner is a keyboard.
The shell executes whatever text it receives.
Compression keeps payloads small and QR-safe.


-------------------------------------------------------------------------------

License

Open and free for all uses.

-------------------------------------------------------------------------------

RAW EXECUTION ENGINE

1. Overview

Bash Cards execute QR-encoded Bash scripts directly through a running shell without storing files or requiring chmod.
A scanner types the payload text directly into the terminal.

-------------------------------------------------------------------------------

2. Execution Model

Raw stdin execution:
• Shell running
• Scanner types payload
• Shell executes it immediately

Difference from file scripts:
File scripts require storage, chmod, and a path.
Bash Cards never create files; they execute in memory via bash -c.

-------------------------------------------------------------------------------

3. Payload Pipeline

Step 1 – Author script
Simple menus, numeric input, finite loops.

Step 2 – Encode
gzip -c card.sh | base64 -w0

Step 3 – Wrap
bash -c "$(echo H4sIAAAAAAAA... | base64 -d | gunzip)"

Alternate:
echo H4sIAAAAAAAA... | base64 -d | gunzip | bash

-------------------------------------------------------------------------------

4. Wrapper Behavior

1. echo prints the base64 data
2. base64 -d decodes the binary gzip stream
3. gunzip decompresses the script
4. bash -c executes the restored program

The script never touches the filesystem.

-------------------------------------------------------------------------------

5. Why No chmod

chmod applies only to files intended for exec.
Here, no file exists.
bash -c reads pure text from memory.

-------------------------------------------------------------------------------

6. Card Script Architecture

Typical decoded script:
• Clears terminal
• Verifies gzip/base64 availability
• Prints menu
• Waits for 1/2/q input
• Executes task
• Returns or chains to another card

-------------------------------------------------------------------------------

7. Security Properties

Benefits:
• Nothing stored on disk
• Immutable physical card behavior
• Deterministic repeats

Risks:
• Payload hides contents
• Full user-level power
• Scanner trust required

Mitigation:
echo <payload> | base64 -d | gunzip > inspect.sh

-------------------------------------------------------------------------------

8. Operational Environments

Ideal for:
• Spacecraft environments
• Industrial control rooms
• Education labs
• Forensics environments
• Field-deployed systems

-------------------------------------------------------------------------------

9. Summary

Bash Cards use:
1. gzip compression
2. base64 encoding
3. a single-line bash reconstruction wrapper

Result:
File-less, scanner-driven, modular Bash automation that runs entirely in memory and executes instantly via QR scan.

-------------------------------------------------------------------------------

END OF DOCUMENT

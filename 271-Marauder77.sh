#!/bin/bash
#!/bin/bash

START=$(date +%s.%N)

DIR_COUNT=$(find / -type d | wc -l)
FILE_COUNT=$(find / -type f | wc -l)

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "Directories: $DIR_COUNT"
echo "Files: $FILE_COUNT"
echo "Time taken: $DIFF seconds"

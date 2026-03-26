#!/bin/bash
# Script 5: Open Source Manifesto Generator

echo "Answer the following questions:"

read -p "1. Open-source tool you use daily: " TOOL
read -p "2. Meaning of freedom (one word): " FREEDOM
read -p "3. Something you want to build: " BUILD

DATE=$(date)
OUTPUT="manifesto.txt"

echo "On $DATE, I believe in the power of open source." > $OUTPUT
echo "Using tools like $TOOL, I experience $FREEDOM." >> $OUTPUT
echo "In the future, I aim to build $BUILD and share it freely with the world." >> $OUTPUT

echo "Manifesto saved in $OUTPUT"
cat $OUTPUT

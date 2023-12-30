#!/bin/bash

file_name="/home/centos/testcounting.txt"

if [ ! -f "$file_name" ]
then
    echo "File does not exist"
    exit 1
fi

wordcount=$(tr -s '[:space:]' '\n' | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | grep -v '^$' | sort | uniq -c | sort -nr)

echo "Top 5 words"
echo "$wordcount" | head -n 5 | awk '{print $2 " - " $1 " occurrences"}
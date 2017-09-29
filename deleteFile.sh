#!/usr/bin/env sh

while true; do

  if [ -f /www/cgi-bin/dummyFile.txt ]; then
    file_creation_time=$(stat --format="%x" /www/cgi-bin/dummyFile.txt | cut -c12-16)
    formatted_file_date=$(echo "${file_creation_time//:}")
    current_time=$(date +"%H%M")

    diff_in_time=$(( $current_time - $formatted_file_date ))

    if [ $diff_in_time -gt 8 ]; then
      echo "It has been: $diff_in_time"
      rm /www/cgi-bin/dummyFile.txt
    fi

  else
    echo "no file"
  fi

  sleep 5
done

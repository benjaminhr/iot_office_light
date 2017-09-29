#!/usr/bin/env sh

while true; do
  curl_all=$() # curl gets all pingdom checks
  checks_result=$(echo $curl_all | grep -o "down" | wc -l)

  curl_usetrace=$() # curl gets only usetrace check
  usetrace_result=$(echo $curl_usetrace | grep -o "down" | wc -l)

  check_file_exists=$([ ! -f /www/cgi-bin/dummyFile.txt ] && echo "does not exist" || echo "exists" )

  if [ "$checks_result" -eq 1 ]  && [ "$usetrace_result" -eq 2 ]; then
    relay-exp -i 1 0
  elif [ "$checks_result" -gt 0 ]; then
    if [ "$check_file_exists" == "does not exist"]; then
      relay-exp -i 1 1
    fi
  else
    relay-exp -i 1 0
  fi

  healthecks=$() # curl gets all healtheck checks
  healthchecks_down=$(echo $healthecks | grep "down")

  if [ "$healthecks_down" != "" ]; then
    if [ "$check_file_exists" == "does not exist"]; then
      relay-exp -i 1 1
      sleep 30
      relay-exp -i 1 0
    fi
  sleep 3
done

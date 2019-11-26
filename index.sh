#!/bin/sh
home="/Users/kellycrowther" ## note -- this will be run as root, ~ is not your normal user
now=$(date "+%Y-%m-%d,%H:%M:%S")
echo $now >> "$home/Desktop/TestFile.txt"

sleep 30s

# send 5 pings to google and write the output to log.txt
ping -c 5 google.com > "$home/kelly-repos/network-speed-log/log.txt"

# find the line with stddev, cut out the min, avg, max, and stddev, and replace the slashes with commas
pingResults=$(grep -i "stddev" $home/kelly-repos/network-speed-log/log.txt | cut -d " " -f 4 | sed 's/\//,/g')

# get current date and hour
today=$(date -u "+%Y-%m-%d %H")
# search airport.preferences for LastConnected in the current hour and return the SSIDString (the network name)
networkName=$(defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences | grep LastConnected -A 14 | grep "$today" -A 14 | grep SSIDString | sed -n '1p' | awk '{print $3}' | sed 's/;//g')

if [ -n "$pingResults" ]; then
  row="${networkName},${pingResults},${now}"
  echo $row
  # append the results to the log.csv file
  echo $row >> "$home/kelly-repos/network-speed-log/log.csv"
fi

# test download and upload speed
# curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -

# empty backup file extension required on OSX using -i flag ex: sed -i '' ...
# sed -i '' 's/\//,/g' tmp.txt

# defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences |grep LastConnected -A 7 
# defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences |grep SSIDString 
# security find-generic-password -w -a NETGEAR28   

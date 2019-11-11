#!/bin/bash

# send 5 pings to google and write the output to log.txt
ping -c 5 google.com > log.txt

# find the line with stddev, cut out the min, avg, max, and stddev, and replace the slashes with commas
pingResults=$(grep -i "stddev" log.txt | cut -d " " -f 4 | sed 's/\//,/g')

# append the results to the log.csv file
echo $pingResults >> log.csv

# empty backup file extension required on OSX using -i flag ex: sed -i '' ...
# sed -i '' 's/\//,/g' tmp.txt


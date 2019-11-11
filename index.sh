#!/bin/bash

# send 5 pings to google and write the output to log.txt
ping -c 5 google.com > log.txt

# find the line with stddev and cut out the min, avg, max, and stddev and append to log.csv
grep -i "stddev" log.txt | cut -d " " -f 4 >> log.csv

# empty backup file extension required on OSX using -i flag ex: sed -i '' ...
# replace slashes with commas
sed -i '' 's/\//,/g' log.csv

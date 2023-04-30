#!/bin/bash
 
# This script takes a host as a parameter and outputs the daily network usage statistics
# for the specified host, including the total, incoming, and outgoing traffic in megabytes.
# The statistics are represented as proportional bars, making it easy to compare the values.
 
# Check if a host was provided as a parameter
if [ -z "$1" ]; then
    echo "Please provide a host as a parameter."
    exit 1
fi
 
host="$1"
log_directory="/var/log/ipfm/"
max_width=50
max_value=0
 
# Function to draw bars
draw_bar() {
    local value=$1
    local max_value=$2
    local width=$3
    local ratio=$(awk -v value="$value" -v max_value="$max_value" -v width="$width" 'BEGIN {print int((value / max_value) * width)}')
 
    for ((count = 1; count <= ratio; count++)); do
        printf "#"
    done
}
 
# Find the maximum value for scaling
for log_file in ${log_directory}internet-*02_00; do
    line=$(awk -v host="$host" '$1 == host {print ($2+$3)/1048576}' $log_file)
    if [ ! -z "$line" ]; then
        total_mb=$line
        current_max=$total_mb
        if (( $(echo "$current_max > $max_value" | bc -l) )); then
            max_value=$current_max
        fi
    fi
done
 
# Iterate through the log files at 2AM in the specified directory
for log_file in ${log_directory}internet-*02_00; do
    # Take the date of the day before as we are using the 2AM file
    date=$(echo $log_file | awk -F- '{split($2, date_parts, "_"); print date_parts[1] "-" date_parts[3] "-" date_parts[2]}')
    previous_date=$(date -d "$date - 1 day" "+%Y/%m/%d")
    echo "Date: $previous_date"
 
    # Extract data for the specified host and convert to megabytes
    line=$(awk -v host="$host" '$1 == host {print $2/1048576, $3/1048576, $4/1048576}' $log_file)
 
    if [ ! -z "$line" ]; then
        in_mb=$(echo $line | awk '{print $1}')
        out_mb=$(echo $line | awk '{print $2}')
        total_mb=$(echo $line | awk '{print $3}')
 
        echo "In (MB): $in_mb"
        #draw_bar $in_mb $max_value $max_width
        echo -e "Out (MB): $out_mb"
        #draw_bar $out_mb $max_value $max_width
        #echo -e "Total (MB): $total_mb - In (MB): $in_mb - Out (MB): $out_mb"
        echo -e "Total (MB): $total_mb"
        draw_bar $total_mb $max_value $max_width
        echo -e "\n"
    fi
done

#!/bin/bash

# Prompt user for subdomains file
read -e -p "Enter the path to the subdomains file: " subdomains_file

# Check if the specified file exists
if [ ! -f "$subdomains_file" ]; then
    echo "Error: The specified file does not exist."
    exit 1
fi

# Output: File to store Nmap scan results
output_file="nmap_scan_results.txt"

# Check if Nmap is installed
if ! command -v nmap &> /dev/null; then
    echo "Nmap is not installed. Please install Nmap and try again."
    exit 1
fi

# Loop through each subdomain and perform an Nmap scan
while IFS= read -r subdomain; do
    echo "Scanning $subdomain..."
    
    # Run Nmap scan and append results to the output file
    nmap_result=$(nmap -p- -T4 "$subdomain")

    # Write the results to the output file with a separator
    echo -e "\n--- $subdomain ---\n$nmap_result\n" >> "$output_file"

done < "$subdomains_file"

echo "Nmap scans completed. Results are saved in $output_file."

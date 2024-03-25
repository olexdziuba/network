# Network Utilities Script

This Bash script provides a set of tools for basic network diagnostics including pinging IP ranges, scanning ports, and more. Designed for simplicity and ease of use, this script is suitable for quickly checking network statuses and open ports.

## Features

- **Ping IP Range**: Ping a specified range of IP addresses.
- **Ping Current Network**: Ping all IP addresses in the current subnet.
- **Port Scanning**: Three modes of port scanning on a specific IP address:
  - Express scan of well-known ports.
  - Scan of the first 1000 ports.
  - Full scan of all 65535 ports.

## How to Use

1. **Clone the Repository**:
   
   ` git clone [your-repository-URL] `

## Navigate to the Script Directory:

    ` cd [your-script-directory] `

## Make the Script Executable (if not already):

   ` chmod +x [script-name].sh `

## Run the Script:

    `./[script-name].sh`

Follow the On-Screen Prompts to choose an option and enter required information as asked.

## Script Options
 0) Exit: Quit the script.
 1) Ping IP Range: Enter the starting and ending IP addresses to ping.
 2) Ping Current Network: Automatically pings all IPs in the current subnet.
 3) Scan Ports (Express): Performs a quick scan of well-known ports on a given IP address.
 4) Scan Ports (First 1000): Scans the first 1000 ports on a specified IP address.
 5) Scan Ports (Full and Long): Conducts a full scan across all 65535 ports on the given IP address.

## Requirements

 - Bash environment.
 - nmap installed for port scanning functionalities.
 - Network connectivity.

## Installation of Dependencies

To install nmap on Debian/Ubuntu:

    `sudo apt-get install nmap`

For other systems, refer to the official Nmap documentation.

## Notes

 - Use this script responsibly and ensure you have permission to scan the network or IP addresses as scanning can be considered intrusive.
 - The script currently supports a /24 subnet mask for the "Ping Current Network" feature. Other subnet sizes may be added in future versions.

Make sure to replace `[your-repository-URL]`, `[your-script-directory]`, and `[script-name].sh` with your actual GitHub repository URL, directory where the script is located, and the script's filename, respectively. This README provides a concise guide for users to understand how to use your network utilities script effectively.

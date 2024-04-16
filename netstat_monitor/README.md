# Network Connections Monitoring Script

This script provides a real-time monitoring tool for network connections, utilizing `netstat` to gather data and `awk` for processing. It is designed to run on Unix/Linux systems and offers customizable parameters for refresh intervals and header reprinting frequency.

## Prerequisites

- A Unix or Linux operating system
- Bash shell
- `netstat` command available
- Permission to execute scripts

## Installation

1. Create a new file for the script, e.g., `netstat_monitor.sh`.
2. Open your preferred text editor and paste the contents of the script into the file.
3. Save and exit the editor.
4. Make the script executable with the following command:
   ```bash
   chmod +x netstat_monitor.sh

## Usage

To run the script, simply execute it from the terminal:

 ` ./netstat_monitor.sh `


The script will start displaying the network connections status in a tabular format, updating every few seconds based on the specified refresh interval.

## Header Descriptions
The table headers represent the following connection states:

- **TIME**: Current time when the data was collected.
- **ESTAB**: Number of established connections.
- **LISTN**: Number of listening ports.
- **T_WAT**: Number of connections in TIME_WAIT state.
- **CLOSD**: Number of closed connections.
- **S_SEN**: Number of connections in SYN_SENT state.
- **S_REC**: Number of connections in SYN_RECEIVED state.
- **C_WAT**: Number of connections in CLOSE_WAIT state.
- **F_WT1**: Number of connections in FIN_WAIT_1 state.
- **F_WT2**: Number of connections in FIN_WAIT_2 state.
- **CLOSI**: Number of connections in CLOSING state.
- **L_ACK**: Number of connections in LAST_ACK state.



This detailed monitoring helps in diagnosing network behavior and troubleshooting issues.



## Features
Real-time monitoring of network connection states.
Customizable refresh intervals and header reprinting frequency.
Tabular display of various connection states including ESTABLISHED, LISTEN, and more.
Stopping the Script
To stop the script, use the keyboard shortcut Ctrl + C.

## Contribution
Contributions are welcome! If you have suggestions for improvements or bug fixes, please create an issue or a pull request in the repository.

## License
This script is provided "as is", without warranty of any kind, express or implied. Use it at your own risk.

## Author
Created by Oleksandr Dziuba



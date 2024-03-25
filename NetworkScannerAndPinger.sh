#!/bin/bash

ping_once() {
    ping -c 1 -W 1 $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Host $1 is up"
    fi
}

ping_range() {
    echo "Enter starting IP address: "
    read start_ip
    echo "Enter ending IP address: "
    read end_ip

    IFS='.' read -r -a start <<< "$start_ip"
    IFS='.' read -r -a end <<< "$end_ip"

    for i in $(seq ${start[3]} ${end[3]}); do
        ip="${start[0]}.${start[1]}.${start[2]}.$i"
        ping_once $ip &
    done
    wait
    return_to_menu_or_exit
}

ping_network() {
    echo "Enter the subnet mask (e.g., 24 for /24 subnet): "
    read subnet_mask
    ip_addr=$(hostname -I | awk '{print $1}')
    IFS='.' read -r -a addr <<< "$ip_addr"
    network="${addr[0]}.${addr[1]}.${addr[2]}"

    if [ "$subnet_mask" -eq 24 ]; then
        for i in {1..254}; do
            ip="$network.$i"
            ping_once $ip &
        done
    else
        echo "Subnet mask not supported in this script version."
    fi
    wait
    return_to_menu_or_exit
}

scan_ports_express() {
    echo "Enter the IP address for express port scanning:"
    read ip_address
    nmap -F $ip_address
    return_to_menu_or_exit
}

scan_ports_first_1000() {
    echo "Enter the IP address for scanning the first 1000 ports:"
    read ip_address
    nmap $ip_address
    return_to_menu_or_exit
}

scan_ports_full() {
    echo "Enter the IP address for full port scanning (this could take a long time):"
    read ip_address
    nmap -p 1-65535 $ip_address
    return_to_menu_or_exit
}

return_to_menu_or_exit() {
    echo "Press ENTER to return to the main menu or any other key then ENTER to exit."
    read -r key
    if [[ $key == "" ]]; then
        menu
    else
        exit 0
    fi
}

menu() {
    echo "Choose an option:"
    echo "0) Exit"
    echo "1) Ping IP range"
    echo "2) Ping current network"
    echo "3) Scan ports on a specific IP (express)"
    echo "4) Scan ports on a specific IP (first 1000)"
    echo "5) Scan ports on a specific IP (full and long)"
    read option

    case $option in
        0) exit 0 ;;
        1) ping_range ;;
        2) ping_network ;;
        3) scan_ports_express ;;
        4) scan_ports_first_1000 ;;
        5) scan_ports_full ;;
        *) echo "Invalid option"; return_to_menu_or_exit ;;
    esac
}

menu

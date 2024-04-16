#!/bin/bash

# Функція для додавання запису DNS
add_dns_record() {
    ip=$1
    domain=$2

    # Додати запис до файлу конфігурації DNSmasq
    echo "address=/$domain/$ip" >> /etc/dnsmasq.conf

    # Перезапустити сервіс DNSmasq
    systemctl restart dnsmasq
}

# Функція для видалення запису DNS
delete_dns_record() {
    ip=$1
    domain=$2

    # Видалити запис з файлу конфігурації DNSmasq
    sed -i "/address=\/$domain\/$ip/d" /etc/dnsmasq.conf

    # Перезапустити сервіс DNSmasq
    systemctl restart dnsmasq
}

# Функція для виведення списку DNS-записів
print_dns_records() {
    file=$1

    echo "Liste des enregistrements DNS:"
    while IFS=',' read -r ip domain; do
        echo "IP: $ip, Domaine: $domain"
    done < "$file"
}

# Головне меню
while true; do
    echo "Menu:"
    echo "1. Ajouter DNS"
    echo "2. Supprimer DNS"
    echo "3. Quitter"

    read -p "Veuillez choisir une option: " option

    case $option in
        1)
            # Додавання DNS-запису
            print_dns_records "add_dns.txt"
            read -p "Voulez-vous ajouter ces enregistrements DNS ? (Y/N) " choice
            if [[ $choice == "Y" || $choice == "y" ]]; then
                while IFS=',' read -r ip domain; do
                    add_dns_record "$ip" "$domain"
                done < "add_dns.txt"
            fi
            ;;
        2)
            # Видалення DNS-запису
            print_dns_records "del_dns.txt"
            read -p "Voulez-vous supprimer ces enregistrements DNS ? (Y/N) " choice
            if [[ $choice == "Y" || $choice == "y" ]]; then
                while IFS=',' read -r ip domain; do
                    delete_dns_record "$ip" "$domain"
                done < "del_dns.txt"
            fi
            ;;
        3)
            # Вихід з програми
            break
            ;;
        *)
            echo "Option invalide. Veuillez choisir une option valide."
            ;;
    esac
done

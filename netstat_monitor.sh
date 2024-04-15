#!/bin/bash

# Vérification de la disponibilité de netstat et awk
if ! command -v netstat &> /dev/null; then
    echo "Erreur: netstat est requis mais n'est pas installé. Veuillez installer net-tools."
    exit 1
fi

if ! command -v awk &> /dev/null; then
    echo "Erreur: awk est requis mais n'est pas installé."
    exit 1
fi

# Initialisation des paramètres
refresh_interval=2
header_interval=10
count=0

print_header() {
    printf "+--------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+\n"
    printf "|  TIME  |ESTAB|LISTN|T_WAT|CLOSD|S_SEN|S_REC|C_WAT|F_WT1|F_WT2|CLOSI|L_ACK|\n"
    printf "+--------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+\n"
}

update_count_and_print_header_if_needed() {
    if [[ $count -eq 0 ]] || [[ $count -eq $header_interval ]]; then
        print_header
        count=0
    fi
    ((count++))
}

# Affichage de l'en-tête avant le début de la boucle
print_header

while :; do
    update_count_and_print_header_if_needed
    TIME=$(/bin/date +%H:%M:%S)
    printf "|%s" "${TIME}"
    netstat -an | awk -v estab=0 -v listen=0 -v time_wait=0 -v closed=0 -v syn_sent=0 -v syn_rcvd=0 -v close_wait=0 -v fin_wait_1=0 -v fin_wait_2=0 -v closing=0 -v last_ack=0 '{
        if ($6 == "CLOSED") closed++;
        else if ($6 == "CLOSE_WAIT") close_wait++;
        else if ($6 == "CLOSING") closing++;
        else if ($6 == "ESTABLISHED") estab++;
        else if ($6 == "FIN_WAIT1") fin_wait_1++;
        else if ($6 == "FIN_WAIT2") fin_wait_2++;
        else if ($6 == "LISTEN") listen++;
        else if ($6 == "LAST_ACK") last_ack++;
        else if ($6 == "SYN_SENT") syn_sent++;
        else if ($6 == "SYN_RCVD") syn_rcvd++;
        else if ($6 == "TIME_WAIT") time_wait++;
    } END {
        printf "| %4d| %4d| %4d| %4d| %4d| %4d| %4d| %4d| %4d| %4d| %4d|\n", estab, listen, time_wait, closed, syn_sent, syn_rcvd, close_wait, fin_wait_1, fin_wait_2, closing, last_ack;
    }'
    sleep "$refresh_interval"
done

#!/bin/bash

threads=4
mkdir -p data
rm -rf data/*.txt

command -v aggregate-prefixes >/dev/null 2>&1 || { echo >&2 "Please install aggregate-prefixes from https://pypi.org/project/aggregate-prefixes/"; exit 1; }

get_ips() {
    local as=$1
    echo $as
    local ip

    for ip in $(echo '!gas'$as | nc whois.radb.net 43 | sed '1,1d ; $ d' | aggregate-prefixes); do
        echo $as,$ip >> data/$as.txt
    done

    for ip in $(echo '!6as'$as | nc whois.radb.net 43 | sed '1,1d ; $ d' | aggregate-prefixes); do
        echo $as,$ip >> data/$as.txt
    done
}
export -f get_ips

printf "%d\n" {1..64495} | xargs -P $threads -I {} bash -c 'get_ips "$@"' _ {}  # 16 bit
printf "%d\n" {131072..141625} | xargs -P $threads -I {} bash -c 'get_ips "$@"' _ {}  # 32 bit APNIC
printf "%d\n" {196608..213403} | xargs -P $threads -I {} bash -c 'get_ips "$@"' _ {}  # 32 bit RIPE NCC
printf "%d\n" {262144..270748} | xargs -P $threads -I {} bash -c 'get_ips "$@"' _ {}  # 32 bit LACNIC
printf "%d\n" {327680..329727} | xargs -P $threads -I {} bash -c 'get_ips "$@"' _ {}  # 32 bit AFRINIC
printf "%d\n" {393216..399260} | xargs -P $threads -I {} bash -c 'get_ips "$@"' _ {}  # 32 bit ARIN

cat $(ls -1v data/*.txt) | grep '/' | uniq > networks.txt

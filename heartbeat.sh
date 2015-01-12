#!/bin/sh

while true; do
    etcdctl set  --ttl '8' /web/`hostname`/ip `ip -o -4 addr show | awk -F '[ /]+' '/global/ {print $4}' | head -n1`
    sleep 2
done


#echo "    ssh -p <port> root@" $(etcdctl set  --ttl '8' /web/`hostname`/ip `ip -o -4 addr show | awk -F '[ /]+' '/global/ {print $4}' | head -n1`)

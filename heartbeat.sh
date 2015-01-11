#!/bin/sh

while true; do
    etcdctl get /web/`hostname`/ip `ip -o -4 addr show | awk -F '[ /]+' '/global/ {print $4}' | head -n1` --ttl '8'
    sleep 2
done



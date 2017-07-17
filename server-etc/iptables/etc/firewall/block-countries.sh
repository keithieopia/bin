#!/bin/bash

# Slightly modified from:
# https://mattwilcox.net/web-development/unexpected-ddos-blocking-china-with-ipset-and-iptables

# Create the ipset list
ipset -N china hash:net
ipset -N russia hash:net

# remove any old list that might exist from previous runs of this script
rm cn.zone
rm ru.zone

# Pull the latest IP set for China & Russia
wget -P . http://www.ipdeny.com/ipblocks/data/countries/cn.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/ru.zone

# Add each IP address from the downloaded list into the ipset 'china'
for i in $(cat /etc/cn.zone ); do ipset -A china $i; done
for i in $(cat /etc/ru.zone ); do ipset -A russia $i; done

# Restore iptables
/sbin/iptables-restore < /etc/firewall/iptables.rules

#!/bin/bash

# Adapted from Matt Wilcox's "Unexpected DDOS: Blocking China with ipset and iptables":
# https://mattwilcox.net/web-development/unexpected-ddos-blocking-china-with-ipset-and-iptables
#
# If you're confused, here's a good guide for Bash associative array witchcraft:
# http://www.artificialworlds.net/blog/2012/10/17/bash-associative-array-examples/


# Known bad actor states (from fail2ban logs, not personal opinion):
declare -A COUNTRIES=( [cn]=china [in]=india [lv]=latvia [ru]=russia [ua]=ukraine [vn]=vietnam )


for country in "${COUNTRIES[@]}"; do 
	# Create the ipset list
	ipset -N "$country" hash:net
done

for tld in "${!COUNTRIES[@]}"; do 
	# remove old lists that might exist from previous runs
	rm "${tld}.zone"
	
	# Pull the latest IP set for the country
	wget -P . "http://www.ipdeny.com/ipblocks/data/countries/${tld}.zone" -o "${tld}.zone"
done


for tld in "${!COUNTRIES[@]}"; do 
	# Make everything a little more readable
	country=${COUNTRIES[$tld]}

	# Add each IP address from the downloaded list into the ipset country
	for i in $(cat "${tld}.zone" ); do 
		ipset -A "$country" $i; 
	done
done


# Restore iptables
/sbin/iptables-restore < /etc/firewall/iptables.rules

#Last update: Thu Mar 20 17:32:03 UTC 2025
/ip firewall address-list remove [/ip firewall address-list find list=IRAN-IP-Address]
/ip firewall address-list
:do { add address=10.0.0.0/8 list=IRAN-IP-Address} on-error={}
#Last update: Thu Mar 20 17:32:03 UTC 2025
/ipv6 firewall address-list remove [/ipv6 firewall address-list find list=IRAN-IP-Address]
/ipv6 firewall address-list

#Last update: Fri Feb  6 01:44:25 UTC 2026
/ip firewall address-list remove [/ip firewall address-list find list=IRAN-IP-Address]
/ip firewall address-list
:do { add address=10.0.0.0/8 list=IRAN-IP-Address} on-error={}
#Last update: Fri Feb  6 01:44:40 UTC 2026
/ipv6 firewall address-list remove [/ipv6 firewall address-list find list=IRAN-IP-Address]
/ipv6 firewall address-list

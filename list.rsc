#Last update: Mon Feb  9 14:47:02 UTC 2026
/ip firewall address-list remove [/ip firewall address-list find list=IRAN-IP-Address]
/ip firewall address-list
:do { add address=10.0.0.0/8 list=IRAN-IP-Address} on-error={}
#Last update: Mon Feb  9 14:49:03 UTC 2026
/ipv6 firewall address-list remove [/ipv6 firewall address-list find list=IRAN-IP-Address]
/ipv6 firewall address-list

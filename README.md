## Get IP Iran

This script is for get Iran ip subnet V4 and V6 and added to address list for Mikrotik

## How to use script

```bash
foreach i in={"IRAN-IP-Address"} do={
  /tool fetch url="https://raw.githubusercontent.com/ChosoMeister/Mikrotik-IRAN-IP-List/master/list.rsc" dst-path=IRAN-IP-Address
  /import file-name=$i
  /file remove $i
}
```

## Author

[Mustafa](https://github.com/ChosoMeister)

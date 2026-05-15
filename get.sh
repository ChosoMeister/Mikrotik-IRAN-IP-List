#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

API_URL="https://stat.ripe.net/data/country-resource-list/data.json?resource=IR&v4_format=prefix"
TEMP_FILE="ripe_data.json"

# Fetch data and verify HTTP status
echo "Fetching IP data from RIPE API..." >&2
HTTP_STATUS=$(curl -s -o "$TEMP_FILE" -w "%{http_code}" -X POST -H 'Connection: close' "$API_URL")

if [ "$HTTP_STATUS" -ne 200 ]; then
    echo "Error: Failed to fetch data. HTTP Status: $HTTP_STATUS" >&2
    rm -f "$TEMP_FILE"
    exit 1
fi

# Validate JSON and check if IPv4 array is populated
IPV4_COUNT=$(jq '.data.resources.ipv4 | length' "$TEMP_FILE" 2>/dev/null || echo 0)
if [ "$IPV4_COUNT" -eq 0 ]; then
    echo "Error: Invalid JSON or empty IPv4 list returned from RIPE." >&2
    rm -f "$TEMP_FILE"
    exit 1
fi

# Set Timezone to Asia/Tehran for the update timestamp
export TZ="Asia/Tehran"
LAST_UPDATE=$(date "+%Y-%m-%d %H:%M:%S %Z")

# Generate IPv4 RSC content
echo "#Last update: $LAST_UPDATE"
echo "/ip firewall address-list remove [/ip firewall address-list find list=IRAN-IP-Address]"
echo "/ip firewall address-list"

# Use jq to directly format and output IPv4 commands, eliminating Bash loops and sed
jq -r '.data.resources.ipv4[] | ":do { add address=\(.) list=IRAN-IP-Address} on-error={}"' "$TEMP_FILE"
echo ":do { add address=10.0.0.0/8 list=IRAN-IP-Address} on-error={}"

# Generate IPv6 RSC content
echo ""
echo "#Last update: $LAST_UPDATE"
echo "/ipv6 firewall address-list remove [/ipv6 firewall address-list find list=IRAN-IP-Address]"
echo "/ipv6 firewall address-list"

# Use jq to directly format and output IPv6 commands
jq -r '.data.resources.ipv6[] | ":do { add address=\(.) list=IRAN-IP-Address} on-error={}"' "$TEMP_FILE"

# Clean up temp file
rm -f "$TEMP_FILE"

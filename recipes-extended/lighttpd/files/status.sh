#!/bin/sh

# Simple CGI script that returns device status in JSON.

echo "Content-type: application/json"
echo ""

HOSTNAME=$(hostname)
UPTIME_RAW=$(cut -d' ' -f1 /proc/uptime)
UPTIME=${UPTIME_RAW%%.*}  # take only the integer part
IP_ADDRESS=$(ip addr show eth0 2>/dev/null | awk '/inet /{print $2}' | cut -d/ -f1 | head -n1)

[ -z "$IP_ADDRESS" ] && IP_ADDRESS="0.0.0.0"

cat <<EOF
{
  "device_id": "$HOSTNAME",
  "firmware_version": "1.0.3",
  "uptime_seconds": $UPTIME,
  "network_mode": "ethernet",
  "ip_address": "$IP_ADDRESS",
  "api_version": "v1"
}
EOF

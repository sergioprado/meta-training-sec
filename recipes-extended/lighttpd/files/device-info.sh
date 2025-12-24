#!/bin/sh
#
# Simple CGI script to show live device information for the
# Embedded Labworks Embedded Security training labs.

echo "Content-Type: text/html"
echo ""

HOSTNAME="$(hostname 2>/dev/null)"

# Try to read a friendly OS name, fallback to uname.
if [ -r /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    OS_NAME="${PRETTY_NAME:-$NAME}"
else
    OS_NAME="$(uname -s)"
fi

KERNEL="$(uname -r 2>/dev/null)"

# Uptime (pretty if available, fallback otherwise)
if command -v uptime >/dev/null 2>&1; then
    # BusyBox uptime usually prints " HH:MM:SS up ...", which is OK.
    UPTIME_RAW="$(uptime 2>/dev/null)"
else
    UPTIME_RAW="N/A"
fi

# Load average (portable way using /proc/loadavg if present)
if [ -r /proc/loadavg ]; then
    LOADAVG="$(cut -d' ' -f1-3 /proc/loadavg)"
else
    LOADAVG="N/A"
fi

# IPv4 addresses (global scope)
if command -v ip >/dev/null 2>&1; then
    IP_ADDRS="$(ip -4 addr show scope global 2>/dev/null | awk '/inet / { print $2 }' | tr '\n' ' ')"
elif command -v ifconfig >/dev/null 2>&1; then
    IP_ADDRS="$(ifconfig 2>/dev/null | awk '/inet addr/ { print $2 }' | cut -d: -f2 | tr '\n' ' ')"
else
    IP_ADDRS="N/A"
fi

# Root filesystem usage
if command -v df >/dev/null 2>&1; then
    ROOT_USAGE="$(df -h / 2>/dev/null | awk 'NR==2 {print $3 " used / " $2 " total (" $5 ")"}')"
else
    ROOT_USAGE="N/A"
fi

cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Device status</title>
    <style>
        body {
            margin: 0;
            padding: 10px 12px;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background: #f7f9fc;
            color: #1f2933;
            font-size: 14px;
        }
        h2 {
            margin: 0 0 6px;
            font-size: 16px;
            color: #0b2e4d;
        }
        .subtitle {
            margin: 0 0 10px;
            font-size: 12px;
            color: #6b7280;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }
        th, td {
            text-align: left;
            padding: 4px 2px;
            vertical-align: top;
        }
        th {
            width: 38%;
            font-weight: 600;
            color: #1f2933;
        }
        tr + tr td, tr + tr th {
            border-top: 1px solid #d0d7e2;
        }
        code {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <h2>Device live status</h2>
    <p class="subtitle">Information collected on the target at request time.</p>
    <table>
        <tr>
            <th>Hostname</th>
            <td><code>${HOSTNAME}</code></td>
        </tr>
        <tr>
            <th>Operating system</th>
            <td>${OS_NAME}</td>
        </tr>
        <tr>
            <th>Kernel</th>
            <td><code>${KERNEL}</code></td>
        </tr>
        <tr>
            <th>Uptime (raw)</th>
            <td><code>${UPTIME_RAW}</code></td>
        </tr>
        <tr>
            <th>Load average</th>
            <td><code>${LOADAVG}</code></td>
        </tr>
        <tr>
            <th>IPv4 addresses</th>
            <td><code>${IP_ADDRS}</code></td>
        </tr>
        <tr>
            <th>Root filesystem usage</th>
            <td>${ROOT_USAGE}</td>
        </tr>
    </table>
</body>
</html>
EOF


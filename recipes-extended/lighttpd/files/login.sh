#!/bin/sh

# Simple CGI script that receives username and password via POST
# and returns a JSON response. This is intentionally insecure
# (HTTP, clear-text credentials) for network security exercises.

VALID_USERNAME="admin"
VALID_PASSWORD="SuperSecret123"

# Read POST body based on CONTENT_LENGTH
BODY=""
if [ -n "$CONTENT_LENGTH" ]; then
	    # Read exactly CONTENT_LENGTH bytes from stdin
	        BODY=$(head -c "$CONTENT_LENGTH")
fi

# BODY example: "username=admin&password=SuperSecret123"
# Extract fields with very simple parsing (no full URL decoding).
USERNAME=$(printf '%s' "$BODY" | tr '&' '\n' | sed -n 's/^username=//p')
PASSWORD=$(printf '%s' "$BODY" | tr '&' '\n' | sed -n 's/^password=//p')

echo "Content-type: application/json"
echo ""

if [ "$USERNAME" = "$VALID_USERNAME" ] && [ "$PASSWORD" = "$VALID_PASSWORD" ]; then
	    cat <<EOF
{"status":"ok","message":"Login successful","username":"$USERNAME"}
EOF
else
	    cat <<EOF
{"status":"error","message":"Invalid credentials"}
EOF
fi

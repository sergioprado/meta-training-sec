#!/bin/sh

echo "Content-Type: text/html"
echo

echo "<!DOCTYPE html>"
echo "<html><head><title>Network Diagnostics</title></head><body>"
echo "<h1>Network Diagnostics</h1>"

QUERY="$QUERY_STRING"

if [ -z "$QUERY" ]; then
    echo "<p>No host provided.</p>"
    echo "</body></html>"
    exit 0
fi

HOST="$(printf '%s' "$QUERY" | sed -n 's/^host=//p')"

if [ -z "$HOST" ]; then
    echo "<p>Invalid query string.</p>"
    echo "</body></html>"
    exit 0
fi

echo "<p>Running ping for host: <b>$HOST</b></p>"
echo "<pre>"

CMD="ping -c 1 $HOST"
sh -c "$CMD"

echo "</pre>"
echo "</body></html>"

#!/bin/bash

URL="http://127.0.0.1:5000/"
REQUEST_COUNT=500

for ((i=1; i<=REQUEST_COUNT; i++))
do
    curl -s -o /dev/null -w "Request $i: HTTP Status %{http_code}\n" "$URL"
done
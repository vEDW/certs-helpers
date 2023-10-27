#!/bin/bash

if [ $# -ne 1 ]; then
    echo
    read -p "No URL provided. Please enter URL of server to collect certs from:" SERVERURL
    echo $SERVERURL
else    
    SERVERURL="${1}"
fi

openssl s_client -showcerts -verify 5 -connect $SERVERURL:443 </dev/null > $SERVERURL.crt

echo "file created: $SERVERURL.crt"

openssl verify -show_chain -untrusted $SERVERURL.crt

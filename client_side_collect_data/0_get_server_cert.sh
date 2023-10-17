#!/bin/bash

if [ $# -ne 1 ]; then
    echo
    read -p "No URL provided. Please enter URL of server to collect certs from:" SERVERURL
    echo $SERVERURL
else    
    SERVERURL="${1}"
fi

openssl s_client -showcerts -connect $SERVERURL:443 </dev/null |  sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $SERVERURL.pem
cat $SERVERURL.pem
echo "file created: $SERVERURL.pem"

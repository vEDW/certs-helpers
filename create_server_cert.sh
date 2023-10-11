#!/bin/bash

if [[ ! -e EasyRSA ]]; then
    echo "Easy-RSA folder not present. stopping script"
    exit
fi

cd EasyRSA

echo "enter server hostname"
read -r HOSTNAME
echo
echo "Enter ip address for ${HOSTNAME}"
read -r HOST_IP

./easyrsa --batch --req-cn=example.org gen-req "${HOSTNAME}" nopass
./easyrsa --batch --subject-alt-name="DNS:${HOSTNAME},IP:${HOST_IP}"  \
    sign-req server "${HOSTNAME}"

#openssl rsa -in pki/private/${HOSTNAME}.key 
cat pki/private/${HOSTNAME}.key  pki/issued/${HOSTNAME}.crt pki/ca.crt >> ${HOSTNAME}.pem
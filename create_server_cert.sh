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

./easyrsa --batch --req-cn="${HOSTNAME}" gen-req "${HOSTNAME}" nopass
./easyrsa --batch --subject-alt-name="DNS:${HOSTNAME},IP:${HOST_IP}"  \
    sign-req server "${HOSTNAME}"

#openssl rsa -in pki/private/${HOSTNAME}.key 

cat pki/issued/${HOSTNAME}.crt | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >> ${HOSTNAME}.pem
cat pki/private/${HOSTNAME}.key | sed -ne '/-BEGIN PRIVATE KEY-/,/-END PRIVATE KEY-/p' >> ${HOSTNAME}.pem
cat pki/ca.crt | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >> ${HOSTNAME}.pem
cat ${HOSTNAME}.pem

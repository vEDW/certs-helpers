#!/bin/bash

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/' |                                    # Pluck JSON value
    cut -d "v" -f 2
}

#checking if EasyRSA already exists
if [[ ! -e ../EasyRSA ]]; then
    echo "Easy-RSA folder not present. stopping script"
    exit
fi

if [[ -e ../EasyRSA/pki ]]; then
    echo "Easy-RSA/pki folder present. stopping script"
    exit
fi

# create vars file
cd ../EasyRSA
./easyrsa init-pki
./easyrsa gen-dh
./easyrsa --batch build-ca nopass

# easyrsa init-pki
# easyrsa --batch build-ca nopass
# easyrsa --batch --req-cn=example.org gen-req example.org nopass
# easyrsa --batch --subject-alt-name='DNS:example.org,DNS:www.example.org'  \
#     sign-req server example.org./eas  
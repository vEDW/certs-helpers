# certs-helpers
tools to handle certs 

# setup
run scripts in 0_setup folder:
- 0_setup/0_get_easyrsa.sh : downloads easyrsa and extracts it.
- 0_setup/1_configure_easyrsa_vars.sh : inits pki and builds ca

# use 
run create_server_cert.sh to create a new server cert interactively

# configure ca cert on clients
## photonos

- copy pki/ca.crt to /etc/ssl/certs/mynewca.pem
- run 

* cp mycertificate.pem /etc/ssl/certs/
* openssl rehash /etc/ssl/certs
* cat /etc/ssl/certs/*.pem > /etc/pki/tls/certs/ca-bundle.crt

# configure certs on servers
## Harbor ova appliance
copy 
When the IP address of the Harbor VM has changed, rotate its certificate:

ssh in to the VM.

Stop the Harbor service:

```systemctl stop harbor```

Back up the old certificate’s server.crt, server.key, ca.crt files by moving or renaming them:

* server.crt is in /storage/data/secret/cert/server.crt
* server.key is in /storage/data/secret/cert/server.key
* ca.crt is in /storage/data/ca_download/ca.crt
Save the new certificate’s server.crt, server.key, ca.crt to the locations above and set their file ownership and permissions to the same settings as the old files.

Start the Harbor service:

```systemctl start harbor```

## ubuntu appliances
Add your rootCA.pem in /usr/share/ca-certificates directory.
After that update your certificates with: update-ca-certificates --fresh command.

## bitnami gitlab

ssh bitnami@gitlab.fqdn

stop gitlab services

    sudo gitlab-ctl stop

sudo cp /etc/gitlab/ssl/server.crt /etc/gitlab/ssl/server.crt.back
sudo cp /etc/gitlab/ssl/server.key /etc/gitlab/ssl/server.key.back

edit server.crt and server.key with the correct info.


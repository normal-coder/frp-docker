#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

install_cert() {
mkdir -p /etc/cert/$DOMAIN
openssl genrsa 1024 > /etc/cert/$DOMAIN/private.key
openssl req -new -key /etc/cert/$DOMAIN/private.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=localhost" > /etc/cert/$DOMAIN/private.csr
openssl req -x509 -days 3650 -key /etc/cert/$DOMAIN/private.key -in /etc/cert/$DOMAIN/private.csr > /etc/cert/$DOMAIN/fullchain.crt
}

# 查看证书，没有就自动创建
if [ ! -f "/etc/cert/$DOMAIN/fullchain.crt" ]; then
  install_cert
fi

if [ ! -f "/var/frp/conf/server.crt" ]; then
  echo copy /etc/cert/$DOMAIN/fullchain.crt to /var/frp/conf/server.crt
  echo copy /etc/cert/$DOMAIN/private.key to /var/frp/conf/server.key
  cp /etc/cert/$DOMAIN/fullchain.crt /var/frp/conf/server.crt
  cp /etc/cert/$DOMAIN/private.key /var/frp/conf/server.key
fi

/var/frp/frps -c /var/frp/conf/frps.ini &
sleep 3
/var/frp/frpc -c /var/frp/conf/frpc.ini

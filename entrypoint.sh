#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

/var/frp/frps -c /var/frp/conf/frps.ini &
/var/frp/frpc -c /var/frp/conf/frpc.ini
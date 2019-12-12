#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
echo "FRP_PORT is $FRP_PORT /tcp
echo "KCP_FRP_PORT is $FRP_PORT /udp
echo "V_HTTP_PORT is $V_HTTP_PORT /tcp
echo "V_HTTPS_PORT is $V_HTTPS_PORT /tcp
/var/frp/frps -c /var/frp/conf/frps.ini &
/var/frp/frpc -c /var/frp/conf/frpc.ini

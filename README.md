Docker for frp

使用docker配置frp服务，用于没有公网IP透传

证书创建方法：

openssl genrsa 1024 > wrt.key

openssl req -new -key wrt.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=localhost" > wrt.csr

openssl req -x509 -days 3650 -key wrt.key -in wrt.csr > wrt.crt

Docker for frp

使用 Docker 配置 frp 服务，用于没有公网 IP 的内网透传：

- Web 服务端口上配合 NGINX Config 转发到本地代理，避免影响其他 Web服务，SSL 从 NGINX 层进行代理。
- 从 Docker 直接开放 10000-10100 端口，用于 SSH 开放端口。
- 从 Docker 直接开放 9443 端口映射 frp 鉴权服务端口 7443。

```bash
docker run -itd --name frps \
  -p 10000-10100:10000-10100 \
  -p 127.0.0.1:8880:80/tcp \
  -p 127.0.0.1:8443:443/tcp \
  -p 9443:7443/tcp \
  -e SUBDOMAIN_HOST=example.com \
  -e DASHBOARD_USER=admin \
  -e DASHBOARD_PWD=87654321 \
  -e TOKEN=12345678 \
  -e ALLOW_PORTS=10000-10100 \
  -e FRP_PORT=7443 \
  -e V_HTTP_PORT=80 \
  -e V_HTTPS_PORT=443 \
  -e DASHBOARD_ADDR=0.0.0.0 \
  -e DASHBOARD_PORT=10075 \
  normalcoder/frp:0.37.0
```

或者直接使用宿主机网络

```bash
docker run -itd --name frps --net=host \
  -e SUBDOMAIN_HOST=example.com \
  -e DASHBOARD_USER=admin \
  -e DASHBOARD_PWD=87654321 \
  -e TOKEN=12345678 \
  -e ALLOW_PORTS=10000-10100 \
  -e FRP_PORT=7443 \
  -e V_HTTP_PORT=80 \
  -e V_HTTPS_PORT=443 \
  -e DASHBOARD_ADDR=0.0.0.0 \
  -e DASHBOARD_PORT=10075 \
  normalcoder/frp:0.37.0
```

自签证书创建方法：

```bash
openssl genrsa 1024 > wrt.key
openssl req -new -key wrt.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=localhost" > wrt.csr
openssl req -x509 -days 3650 -key wrt.key -in wrt.csr > wrt.crt
```
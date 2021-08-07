FROM alpine:3.12
MAINTAINER 诺墨 <normal@normalcoder.com>

ENV DOMAIN frp.youdomain.com
ENV DASHBOARD_USER admin
ENV DASHBOARD_PWD password
ENV TOKEN 12345678
ENV ALLOW_PORTS 10000-10100
ENV MAX_POOL_COUNT 10

ENV FRP_PORT 7443
ENV V_HTTP_PORT 80
ENV V_HTTPS_PORT 443

ENV DASHBOARD_ADDR 0.0.0.0
ENV DASHBOARD_PORT 7500

ENV TZ=Asia/Shanghai

ARG Frp_ver=0.37.0

RUN apk add --no-cache tzdata ca-certificates openssl && \
    wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${Frp_ver}/frp_${Frp_ver}_linux_amd64.tar.gz && \
    tar -zxf frp_${Frp_ver}_linux_amd64.tar.gz && \
    mkdir /var/frp && \
    mv frp_${Frp_ver}_linux_amd64/* /var/frp && \
    rm -rf frp_${Frp_ver}_linux_amd64.tar.gz 

RUN mkdir /var/frp/conf
ADD frpc.ini /var/frp/conf
ADD frps.ini /var/frp/conf
ADD 404.html /var/frp/conf
#ADD server.crt /var/frp/conf
#ADD server.key /var/frp/conf


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

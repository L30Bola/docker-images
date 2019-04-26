FROM alpine:3.9

LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com"

ENV TIMEZONE="America/Sao_Paulo"

ARG ARIA2_RPC_SECRET='secret-token'

RUN apk --no-cache upgrade && \
    apk --no-cache add tzdata \
                       aria2 \
                       aria2-daemon && \
    cp -f /usr/share/zoneinfo/"${TIMEZONE}" /etc/localtime && \
    apk del tzdata && \
    mkdir -p /var/lib/aria2/ && \
    sed -i '/#rpc-listen-port=6800/s/#//' /etc/aria2.conf && \
    sed -i 's|#rpc-listen-all=false|rpc-listen-all=true|g' /etc/aria2.conf && \
    sed -i "/rpc-secret=top-secret/s/top-secret/${ARIA2_RPC_SECRET}/" /etc/aria2.conf && \
    sed -i 's|input-file=/var/lib/aria2/aria2.session|#input-file=/var/lib/aria2/aria2.session|g' /etc/aria2.conf && \
    echo 'daemon=false' >> /etc/aria2.conf && \
    echo 'enable-rpc=true' >> /etc/aria2.conf

EXPOSE 6800

ENTRYPOINT ["/usr/bin/aria2c"]
CMD ["--conf-path", "/etc/aria2.conf"]

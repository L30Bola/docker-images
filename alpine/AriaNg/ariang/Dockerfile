ARG ARIANG_VERSION="1.1.0"

FROM alpine:3.9 AS build

LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com"

ENV ARIANG_DOWNLOAD_URL="https://github.com/mayswind/AriaNg/archive"

ARG ARIANG_VERSION

RUN apk --no-cache add git \
                       nodejs \
                       npm && \
    npm install -g gulp && \
    wget "${ARIANG_DOWNLOAD_URL}/${ARIANG_VERSION}".tar.gz -O /tmp/ariang.tar.gz && \
    tar zxf /tmp/ariang.tar.gz -C /tmp/ && \
    cd /tmp/AriaNg-"${ARIANG_VERSION}" && \
#https://github.com/gulpjs/gulp/issues/2280
    npm install natives@1.1.6 && \
    gulp clean build

FROM alpine:3.9

LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com"

ENV TIMEZONE="America/Sao_Paulo" \
    NGINX_HOME="/etc/nginx" \
    NGINX_PID="/run/nginx" \
    NGINX_LOG="/var/log/nginx" \
    NGINX_DOCUMENT_ROOT="/var/www/localhost/htdocs"

ARG ARIANG_VERSION

RUN apk --no-cache upgrade && \
    apk --no-cache add tzdata \
                       nginx && \
    cp -f /usr/share/zoneinfo/"${TIMEZONE}" /etc/localtime && \
    apk del tzdata && \
    mkdir -p "${NGINX_PID}" && \
    rm -f "${NGINX_HOME}"/conf.d/default.conf && \
    chown nginx: -R "${NGINX_DOCUMENT_ROOT}" "${NGINX_DOCUMENT_ROOT}" "${NGINX_LOG}"
 
COPY --from=build --chown=nginx:nginx /tmp/AriaNg-"${ARIANG_VERSION}"/dist/ "${NGINX_DOCUMENT_ROOT}"/ariang/

COPY ./FILES/ariang.conf "${NGINX_HOME}"/conf.d/

EXPOSE 80

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]

FROM alpine:3.9

LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com"

ENV TIMEZONE="America/Sao_Paulo" \
    HTTPD_HOME="/etc/apache2" \
    HTTPD_PID="/run/apache2" \
    HTTPD_LOG="/var/log/apache2" \
    HTTPD_DOCUMENT_ROOT="/var/www/localhost/htdocs" \
    ARIANG_DOWNLOAD_URL="https://github.com/mayswind/AriaNg/archive" \
    ARIANG_VERSION="1.0.3"

ADD "${ARIANG_DOWNLOAD_URL}/${ARIANG_VERSION}".tar.gz /tmp/ariang.tar.gz

COPY ./FILES/apache2-entrypoint.sh /

RUN apk --no-cache upgrade && \
    apk --no-cache add apache2 \
                       git \
                       nodejs \
                       npm \
                       aria2 \
                       aria2-daemon \
                       tzdata && \
    npm install -g gulp && \
    cp -f /usr/share/zoneinfo/"${TIMEZONE}" /etc/localtime && \
    tar zxf /tmp/ariang.tar.gz -C "${HTTPD_DOCUMENT_ROOT}" && \
    mv "${HTTPD_DOCUMENT_ROOT}"/AriaNg-"${ARIANG_VERSION}" "${HTTPD_DOCUMENT_ROOT}"/ariang && \
    cd "${HTTPD_DOCUMENT_ROOT}"/ariang && \
#https://github.com/gulpjs/gulp/issues/2280
    npm install natives@1.1.6 && \     
    gulp clean build && \
    sed -i '/Listen 80/s/80/0.0.0.0:80/' /etc/apache2/httpd.conf && \
    apk --no-cache del tzdata && \
    mkdir -p "${HTTPD_PID}" && \
    chmod +x /apache2-entrypoint.sh && \
    chown -R apache:apache "${HTTPD_PID}" "${HTTPD_DOCUMENT_ROOT}" "${HTTPD_LOG}" 

ENTRYPOINT ["/apache2-entrypoint.sh"]

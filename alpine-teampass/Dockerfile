FROM alpine:3.8

LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com"

ENV HTTPD_HOME="/etc/apache2" \
    HTTPD_PID="/run/apache2" \
    HTTPD_LOG="/var/log/apache2" \
    HTTPD_DOCUMENT_ROOT="/var/www/localhost/htdocs" \
    TEAMPASS_VERSION="2.1.27.21" 

COPY ./FILES/teampass-entrypoint.sh /

RUN apk --no-cache upgrade && \
    apk --no-cache add apache2 \
                       openssl \
                       php7 \
                       php7-apache2 \
                       php7-bcmath \
                       php7-curl \
                       php7-gd \
                       php7-iconv \
                       php7-json \
                       php7-ldap \
                       php7-mbstring \
                       php7-mcrypt \
                       php7-mysqli \
                       php7-pear \
                       php7-session \
                       php7-xml  \
                       tzdata && \
    cp -f /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    wget -O- https://github.com/nilsteampassnet/TeamPass/archive/"${TEAMPASS_VERSION}".tar.gz | tar -zxf - -C "${HTTPD_DOCUMENT_ROOT}" && \
    mv "${HTTPD_DOCUMENT_ROOT}"/TeamPass-"${TEAMPASS_VERSION}" "${HTTPD_DOCUMENT_ROOT}"/teampass && \
    sed -i '/date.timezone/s/.*/date.timezone = America\/Sao_Paulo/' /etc/php7/php.ini && \
    sed -i '/post_max_size/s/.*/post_max_size = 80M/' /etc/php7/php.ini && \
    sed -i '/upload_max_filesize/s/.*/upload_max_filesize = 80M/' /etc/php7/php.ini && \
    sed -i '/max_execution_time/s/.*/max_execution_time = 120/' /etc/php7/php.ini && \
    sed -i '/Listen 80/s/80/0.0.0.0:80/' /etc/apache2/httpd.conf && \
    apk --no-cache del tzdata && \
    mkdir /run/apache2 "${HTTPD_DOCUMENT_ROOT}"/teampass/sk && \
    chmod +x /teampass-entrypoint.sh && \
    chown -R apache:apache "${HTTPD_PID}" "${HTTPD_DOCUMENT_ROOT}" "${HTTPD_LOG}" 

VOLUME ["${HTTPD_DOCUMENT_ROOT}/teampass/sk", "${HTTPD_DOCUMENT_ROOT}/teampass/includes/config"]

ENTRYPOINT ["/teampass-entrypoint.sh"]

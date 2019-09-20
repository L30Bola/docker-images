LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com"

ENV FREENOM_SCRIPT_GITREPO_URL="https://github.com/mkorthof/freenom-script.git"

COPY ./FILES/docker-entrypoint.sh /

RUN apk --no-cache upgrade && \
    apk --no-cache add git && \
    git clone "${FREENOM_SCRIPT_GITREPO_URL}" /opt/freenom-script && \
    chmod +x /docker-entrypoint.sh

WORKDIR /opt/freenom-script

ENTRYPOINT ["/docker-entrypoin.sh"]

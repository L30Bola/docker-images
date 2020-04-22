ARG T50_CLONE_DIR="/opt/t50"

FROM alpine:3.11 AS builder

LABEL "maintainer" = "Leonardo Godoy <leonardoggavellar@gmail.com>"

ENV T50_GIT_REPO_URL="https://gitlab.com/fredericopissarra/t50" \
    T50_VERSION="5.8.7"

ARG T50_CLONE_DIR

RUN apk add --no-cache git \
                       make \
                       gcc \
                       musl-dev \
                       linux-headers && \
    git clone --branch "v${T50_VERSION}" "${T50_GIT_REPO_URL}" "${T50_CLONE_DIR}" && \
    cd "${T50_CLONE_DIR}" && \
    USE_ANSI=1 make

FROM alpine:3.11

ARG T50_CLONE_DIR

COPY --from=builder "${T50_CLONE_DIR}/bin/t50" /usr/local/bin/

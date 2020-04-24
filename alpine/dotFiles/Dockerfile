FROM alpine:3.11

LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com>"

ENV TIMEZONE="America/Sao_Paulo" \
    DOTFILES_REPO="https://github.com/l30bola/dotFiles.git" \
    SHELLCHECK_STABLE_BIN_URL="https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz" \
    SHFMT_BIN_URL="https://github.com/mvdan/sh/releases/download/v3.1.0/shfmt_v3.1.0_linux_amd64"

RUN apk --no-cache add git vim bash bash-completion tmux ncurses tzdata curl busybox-extras && \
    cp -f /usr/share/zoneinfo/"${TIMEZONE}" /etc/localtime && \
    apk del tzdata
    
RUN git clone "${DOTFILES_REPO}" "${HOME}"/.vim && \
    "${HOME}"/.vim/prepareHome.sh all https force

RUN curl -L "${SHFMT_BIN_URL}" -o /usr/local/bin/shfmt && \
    chmod +x /usr/local/bin/shfmt && \
    wget "${SHELLCHECK_STABLE_BIN_URL}" -O /tmp/shellcheck.tar.xz && \
    tar Jxf /tmp/shellcheck.tar.xz -C /tmp/ && \
    mv /tmp/shellcheck-stable/shellcheck /usr/local/bin/ && \
    rm -rf /tmp/shellcheck-stable /tmp/shellcheck.tar.gz

SHELL ["/bin/bash", "-i"]

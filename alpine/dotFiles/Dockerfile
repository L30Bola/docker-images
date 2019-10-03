FROM alpine:3.10

LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com>"

ENV TIMEZONE="America/Sao_Paulo" \
    DOTFILES_REPO="https://github.com/l30bola/dotFiles.git" \
    SHELLCHECK_STABLE_BIN_URL="https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz"

RUN apk --no-cache add git vim bash bash-completion tmux ncurses tzdata && \
    cp -f /usr/share/zoneinfo/"${TIMEZONE}" /etc/localtime && \
    apk del tzdata && \
    git clone "${DOTFILES_REPO}" "${HOME}"/.vim && \
    "${HOME}"/.vim/prepareHome.sh all https force && \
    wget "${SHELLCHECK_STABLE_BIN_URL}" -O /tmp/shellcheck.tar.xz && \
    tar Jxf /tmp/shellcheck.tar.xz -C /tmp/ && \
    mv /tmp/shellcheck-stable/shellcheck /usr/local/bin/ && \
    rm -rf /tmp/shellcheck-stable /tmp/shellcheck.tar.gz

SHELL ["/bin/bash", "-i"]

FROM debian:stretch-slim

LABEL maintainer="Leonardo Godoy <leonardoggavellar@gmail.com>"

ENV TIMEZONE="America/Sao_Paulo" \
    DOTFILES_REPO="https://github.com/l30bola/dotFiles.git" \
    SHELLCHECK_STABLE_BIN_URL="https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz" \
    SHFMT_BIN_URL="https://github.com/mvdan/sh/releases/download/v3.1.0/shfmt_v3.1.0_linux_amd64"

RUN apt update && \
    apt install -y git vim bash bash-completion tmux curl xz-utils locales && \
    rm -rf /var/lib/apt/lists/* && \
    cp -f /usr/share/zoneinfo/"${TIMEZONE}" /etc/localtime

RUN sed -i \
      -e 's|.*pt_BR.UTF-8.*|pt_BR.UTF-8 UTF-8|' \
      -e 's|.*en_US.UTF-8.*|en_US.UTF-8 UTF-8|' /etc/locale.gen && \
    locale-gen

RUN git clone "${DOTFILES_REPO}" "${HOME}"/.vim && \
    "${HOME}"/.vim/prepareHome.sh all https force

RUN curl -L "${SHFMT_BIN_URL}" -o /usr/local/bin/shfmt && \
    chmod +x /usr/local/bin/shfmt && \
    curl -L "${SHELLCHECK_STABLE_BIN_URL}" -o /tmp/shellcheck.tar.xz && \
    tar Jxf /tmp/shellcheck.tar.xz -C /tmp/ && \
    mv /tmp/shellcheck-stable/shellcheck /usr/local/bin/ && \
    rm -rf /tmp/shellcheck-stable /tmp/shellcheck.tar.gz

SHELL ["/bin/bash", "-i"]

FROM bash:latest

LABEL maintainer="Girish Pasupathy"

# Default Settings
ENV BASH_USER="basher"
ENV USER_HOME="/home/${BASH_USER}"

RUN \
    apk add --no-cache git curl jq bash-completion fzf && \
    adduser -h ${USER_HOME} -s /bin/bash -u 1000 -D ${BASH_USER}

USER ${BASH_USER}
WORKDIR "${USER_HOME}"

RUN mkdir ~/.bash-it && \
    git clone --depth=1 "https://github.com/Bash-it/bash-it.git" ~/.bash_it && \
    ~/.bash_it/install.sh --silent

COPY .bashrc_docker "${USER_HOME}/.bashrc"

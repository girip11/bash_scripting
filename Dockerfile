FROM bash:latest

LABEL maintainer="Girish Pasupathy"

# Default Settings
ENV USER="basher"
ENV USER_HOME="/home/${USER}"
ENV BASH_IT_DIR="/home/${USER}/.bash_it"

RUN \
    apk add --no-cache sudo git curl jq bash-completion fzf && \
    adduser -h ${USER_HOME} -s /bin/bash -u 1000 -D ${USER} && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER  && \
    chmod 0440 /etc/sudoers.d/$USER

USER ${USER}
WORKDIR "${USER_HOME}"

RUN mkdir "${BASH_IT_DIR}" && \
    git clone --depth=1 "https://github.com/Bash-it/bash-it.git" "${BASH_IT_DIR}" && \
    "${BASH_IT_DIR}/install.sh" --silent

COPY .bashrc_docker "${USER_HOME}/.bashrc"

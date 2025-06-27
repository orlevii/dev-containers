ARG BASE_IMAGE="ubuntu:24.04"
FROM $BASE_IMAGE AS base-zsh

# Settings
ENV LC_ALL "C.UTF-8" \
    LANG "C.UTF-8"

# apt get packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install --yes --no-install-recommends \
    zsh \
    curl \ 
    unzip \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    git \
    openssh-client \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install OhMyZsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY zsh/git-prompt.sh /root/
COPY zsh/ubuntu.zsh-theme /root/.oh-my-zsh/themes
RUN sed -i 's/^ZSH_THEME="robbyrussell"$/ZSH_THEME="ubuntu"/' ~/.zshrc && \
    echo "fpath+=~/.zfunc" >> ~/.zshrc && \
    echo "source ~/git-prompt.sh" >> ~/.zshrc && \
    echo "GIT_PS1_SHOWDIRTYSTATE=true" >> ~/.zshrc

WORKDIR /

SHELL ["/bin/zsh", "-ec"]
ENTRYPOINT [ "/bin/zsh" ]

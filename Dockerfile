FROM ubuntu:18.04

ARG UNAME=testuser
ARG UID=1000
ARG GID=1000

#Install shell and tools
RUN apt-get update && apt-get install -y \
    git \
    zsh \
    apt-transport-https \
    ca-certificates \
    wget \
    curl \
    tmux \
    vim \
    sudo \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

#Enable sudo
RUN groupadd -g $GID -o $UNAME && useradd -m -u $UID -g $GID -o -s /bin/zsh $UNAME \
    && adduser $UNAME sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#Install build tools
RUN apt-get update && apt-get -y install build-essential cmake cppcheck valgrind \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

#Create User configuration
USER $UNAME
WORKDIR /home/$UNAME
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN sed -i 's/ZSH_THEME=".*"/ZSH_THEME="fino"/g' $HOME/.zshrc

COPY tmux.conf /home/$UNAME/.tmux.conf
COPY gitconfig /home/$UNAME/.gitconfig


CMD /bin/zsh


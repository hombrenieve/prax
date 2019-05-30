FROM ubuntu:18.04

ARG UNAME=testuser
ARG UID=1000
ARG GID=1000

RUN apt update && apt install -y git zsh apt-transport-https ca-certificates wget curl sudo

RUN groupadd -g $GID -o $UNAME && useradd -m -u $UID -g $GID -o -s /bin/zsh $UNAME &&\
    adduser $UNAME sudo &&\
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER $UNAME
WORKDIR /home/$UNAME
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

CMD /bin/zsh


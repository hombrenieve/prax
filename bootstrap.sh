#!/usr/bin/env bash

DOCKER_VERSION="18.06.1~ce~3-0~ubuntu"


echo -e "#\n### DOCKER ###\n#"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce=${DOCKER_VERSION} docker-compose
sudo usermod -aG docker $USER

echo -e "#\n### ZSH ###\n#"
sudo apt install -y zsh git
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

echo -e "#\n### Development tools ###\n#"
sudo apt install -y tmux vim
sudo apt install -y openjdk-11-jdk-headless maven
#chrome for selenium
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo mv google-chrome-stable_current_amd64.deb /var/cache/apt/archives/
sudo apt install -y google-chrome-stable

echo -e "\n-> Enabling login with password"
sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Present available DISPLAY to user
echo 'echo -e "\nAvailable displays\n------------------"
netstat -lnt|awk @/127.0.0.1/&&sub(/.*:/,"",$4)&&$4>=6000&&$4<6100 {printf("DISPLAY=localhost:%d\n",$4-6000)}@
ls -1 /tmp/.X11-unix | sed "s/X//" |xargs -I{} echo "DISPLAY=localhost:{}"' | tr "@" "'" >>~/.bashrc

touch /home/vagrant/.Xauthority


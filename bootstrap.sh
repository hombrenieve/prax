#!/usr/bin/env bash

echo -e "#\n### DOCKER ###\n#"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

echo -e "#\n### ZSH ###\n#"
sudo apt install -y zsh git
curl -so ohMyZsh.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

echo -e "#\n### Development tools ###\n#"
sudo apt install -y tmux vim

echo -e "\n-> Enabling login with password"
sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Present available DISPLAY to user
echo 'echo -e "\nAvailable displays\n------------------"
netstat -lnt|awk @/127.0.0.1/&&sub(/.*:/,"",$4)&&$4>=6000&&$4<6100 {printf("DISPLAY=localhost:%d\n",$4-6000)}@
ls -1 /tmp/.X11-unix | sed "s/X//" |xargs -I{} echo "DISPLAY=localhost:{}"' | tr "@" "'" >>~/.bashrc

touch /home/vagrant/.Xauthority


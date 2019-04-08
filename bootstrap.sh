#!/usr/bin/env bash

DOCKER_VERSION="18.06.1~ce~3-0~ubuntu"


echo -e "#\n### DOCKER ###\n#"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce=${DOCKER_VERSION}
sudo usermod -aG docker $USER

echo -e "#\n### VS CODE ###\n#"
sudo apt install -y software-properties-common apt-transport-https wget libx11-xcb1 libasound2
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install -y code


echo -e "#\n### VS CODE - PLUGINS ###\n#"
VSCODE_PLUGINS_DIR=~/Downloads/vscode-plugins
mkdir -p $VSCODE_PLUGINS_DIR
wget -qP $VSCODE_PLUGINS_DIR https://github.com/Microsoft/vscode-cpptools/releases/download/0.22.1/cpptools-linux.vsix
code --install-extension ${VSCODE_PLUGINS_DIR}/cpptools-linux.vsix

echo -e "\n-> Enabling login with password"
sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Present available DISPLAY to user
echo 'echo -e "\nAvailable displays\n------------------"
netstat -lnt|awk @/127.0.0.1/&&sub(/.*:/,"",$4)&&$4>=6000&&$4<6100 {printf("DISPLAY=localhost:%d\n",$4-6000)}@
ls -1 /tmp/.X11-unix | sed "s/X//" |xargs -I{} echo "DISPLAY=localhost:{}"' | tr "@" "'" >>~/.bashrc

touch /home/vagrant/.Xauthority


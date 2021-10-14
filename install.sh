#--------------------------------------------------------#
# Shell Script to auto install Docker and docker-compose #
#            Run on Ubuntu 18.04 or Later                #
#              Created by Adriano Righi                  #
#                  adrianorighi.com                      #
#--------------------------------------------------------#

# Script only works if sudo caches the password for a few minutes
sudo true

# Install dialog
echo 'deb http://archive.ubuntu.com/ubuntu bionic main universe' | sudo tee -a /etc/apt/sources.list > /dev/null
sudo apt update
sudo apt install -y dialog

# Install Docker
wget -qO- https://get.docker.com/ | sh

# Install docker-compose
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# Install docker-cleanup command
cd /tmp
git clone https://gist.github.com/76b450a0c986e576e98b.git
cd 76b450a0c986e576e98b
sudo mv docker-cleanup /usr/local/bin/docker-cleanup
sudo chmod +x /usr/local/bin/docker-cleanup

# Add user to docker group to run without sudo
sudo usermod -aG docker $USER

dialog --backtitle "Auto Install Docker and Docker-Compose" --title "Sucesso" --clear --msgbox "Docker e docker-compose instalados com sucesso. Faça o logoff e login novamente para usar!" 8 40

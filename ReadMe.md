echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
sudo visudo -c

sudo apt update
sudo apt install software-properties-common unzip sshpass python3-pip -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
pip3 install kubernetes
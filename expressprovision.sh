## Compiled by Dawood, This script provisions Servers Australia ExpressVPN Ubuntu servers that require a manual install
echo "AUTOMATED SCRIPT RUNNING, USER PROMPTS ARE PRESENT"
sudo passwd root

sudo apt-get update -y

sudo apt-get upgrade -y

sudo nano /etc/ssh/sshd_config

sudo service ssh restart

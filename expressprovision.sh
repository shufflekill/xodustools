## Compiled by Dawood, This script provisions Servers Australia ExpressVPN Ubuntu servers that require a manual install
echo "AUTOMATED SCRIPT RUNNING, USER PROMPTS ARE PRESENT"
sudo passwd root

su

apt-get update -y

apt-get upgrade -y

nano /etc/ssh/sshd_config

service ssh restart

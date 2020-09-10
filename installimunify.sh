## Just some copy and pasted fun

sh /etc/cxs/uninstall.sh

wget https://repo.imunify360.cloudlinux.com/defence360/i360deploy.sh
bash i360deploy.sh
rm -f i360deploy.sh


curl -s https://repo.cloudlinux.com/kernelcare/kernelcare_install.sh | bash

imunify360-agent register IPL

imunify360-agent whitelist ip add 202.130.35.150 || imunify360-agent whitelist ip move 202.130.35.150    # Nagios
imunify360-agent whitelist ip add 221.121.128.73 || imunify360-agent whitelist ip move 221.121.128.73    # Support VPN
imunify360-agent whitelist ip add 180.92.199.107 || imunify360-agent whitelist ip move 180.92.199.107    # Puppet



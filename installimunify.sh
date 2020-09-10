## Just some copy and pasted fun

echo "removing CXS from system"
sh /etc/cxs/uninstall.sh

wget https://repo.imunify360.cloudlinux.com/defence360/i360deploy.sh
bash i360deploy.sh
rm -f i360deploy.sh

echo "Installing KernelCare..."
curl -s https://repo.cloudlinux.com/kernelcare/kernelcare_install.sh | bash


imunify360-agent register IPL

echo "Adding SAU Nagios IP To Whitelist"
imunify360-agent whitelist ip add 202.130.35.150 || imunify360-agent whitelist ip move 202.130.35.150    # Nagios
echo "Adding SAU Support VPN IP To Whitelist"
imunify360-agent whitelist ip add 221.121.128.73 || imunify360-agent whitelist ip move 221.121.128.73    # Support VPN
echo "Adding Puppet Server's IP To Whitelist"
imunify360-agent whitelist ip add 180.92.199.107 || imunify360-agent whitelist ip move 180.92.199.107    # Puppet



echo "Script Has Completed, Click the below link to check"
whmlogin



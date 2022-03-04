#!/bin/bash
## R1Soft Dedicated Server Provisioning Bash Script
## Author: Dawood Ahmad

# Installing Prerequisites
echo "Installing Prerequisites..."
yum -y install bind-utils perl-libwww-perl perl-LWP-Protocol-https wget telnet unzip zip vim net-tools screen nmap rsync policycoreutils-python pciutils mutt curl dos2unix


dos2unix r1softdedi.sh
# Adding to Puppet
echo "Adding to Puppet..."
echo "Enter the SAU Order ID In Caps (e.g SAU-1337X-OR):"
read orderid


curl -s http://sw-dl.servercontrol.com.au/s_uploads/puppet-agent.sh | bash -s $orderid.customer.servercontrol.com.au


# Changing SSH Port
echo "Changing SSH Port..."
semanage port -a -t ssh_port_t -p tcp 2929

# Installing CSF
echo "Installing CSF..."
cd /usr/src
rm -fv csf.tgz
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh

cd


# Whitelisting IPs...
echo "Whitelisting IPs..."
wget http://sw-dl.servercontrol.com.au/s_uploads/r1soft/sbm.csf.conf -O /etc/csf/csf.conf

echo "221.121.128.73 # SAU StaffNet IP" >> /etc/csf/csf.allow
echo "180.92.199.107 # SAU Puppet Orchestration" >> /etc/csf/csf.allow
echo "221.121.131.3 # R1Soft DCC" >> /etc/csf/csf.allow
echo "117.120.8.42 # Zabbix" >> /etc/csf/csf.allow
echo "202.130.32.198 # R1Soft configuration backups" >> /etc/csf/csf.allow
echo "169.46.82.174/31 # Rsyslog monitoring" >> /etc/csf/csf.allow
echo "169.46.82.176/31 # Rsyslog monitoring" >> /etc/csf/csf.allow
echo "221.121.128.73 # SAU StaffNet IP" >> /etc/csf/csf.ignore
echo "exe:/usr/libexec/postfix/local" >> /etc/csf/csf.pignore
echo "exe:/usr/libexec/postfix/pickup" >> /etc/csf/csf.pignore
echo "exe:/usr/libexec/postfix/qmgr" >> /etc/csf/csf.pignore
echo "exe:/usr/sbin/nrpe" >> /etc/csf/csf.pignore
csf -r

## Get R1Soft Repo
echo '[r1soft]
name=R1Soft Repository Server
baseurl=http://repo.r1soft.com/yum/stable/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/r1soft.repo

yum install -y serverbackup-enterprise

# Setting Username and Password
echo "Set the Password for the Web UI now:"
read Password
/usr/bin/serverbackup-setup --user $orderid --pass $Password
/etc/init.d/cdp-server restart

# SSL Cert Update
echo "Updating SSL Certificate..."
wget http://sw-dl.servercontrol.com.au/s_uploads/r1soft/customer.servercontrol.keystore -O /usr/sbin/r1soft/conf/customer.servercontrol.keystore
\cp /usr/sbin/r1soft/conf/customer.servercontrol.keystore /usr/sbin/r1soft/conf/keystore -p
sed -i "/ssl-keystore=*/c\ssl-keystore=/usr/sbin/r1soft/conf/customer.servercontrol.keystore" /usr/sbin/r1soft/conf/web.properties
sed -i "/ssl-redirect=*/c\ssl-redirect=true" /usr/sbin/r1soft/conf/web.properties

# Console Communication Options
#echo "Changing Console Communication Options..."
#sed -i "/external-host-address=*/c\external-host-address=$orderid.customer.servercontrol.com.au" /usr/sbin/r1soft/conf/web.properties

# Change Task Scheduler Options
#sed -i "/max-running-verification-tasks=*/c\max-running-verification-tasks=2" /usr/sbin/r1soft/conf/web.properties
#sed -i "/max-running-restore-tasks=*/c\max-running-restore-tasks=3" /usr/sbin/r1soft/conf/web.properties
#sed -i "/max-running-replication-tasks=*/c\max-running-replication-tasks=2" /usr/sbin/r1soft/conf/web.properties
#sed -i "/max-running-tasks=*/c\max-running-tasks=3" /usr/sbin/r1soft/conf/web.properties
#sed -i "/max-running-lta-tasks=*/c\max-running-lta-tasks=2" /usr/sbin/r1soft/conf/web.properties
#sed -i "/max-running-policy-tasks=*/c\max-running-policy-tasks=3" /usr/sbin/r1soft/conf/web.properties
#sed -i "/allow-non-super-user-concurrent-restores=*/c\allow-non-super-user-concurrent-restores=true" /usr/sbin/r1soft/conf/web.properties
#sed -i "/allow-control-panel-user-concurrent-restores=*/c\allow-control-panel-user-concurrent-restores=true" /usr/sbin/r1soft/conf/web.properties





service cdp-server stop
service docstore stop
service cdp-server start
service docstore start

#!/bin/bash
##############################################################
#                                                            #
# Author：Changed By Siemenstutorials                        #
#                                                            #
# Youtube channel:https://www.youtube.com/c/siemenstutorials #
#                                                            # 
# L2tp/IkEv2-OneKey v1.0 For CentOS7                         #
#                                                            #
##############################################################
#download vpn.sh
wget -N --no-check-certificate https://raw.githubusercontent.com/siemenstutorials/L2tp/master/vpnsetup_centos.sh
chmod +x vpnsetup_centos.sh
./vpnsetup_centos.sh

#iptables 
yum install -y iptables
yum install -y iptables-services
iptables -P INPUT ACCEPT
iptables -F
iptables -X
iptables -Z
#auto iptables & xl2tpd 
service iptables save
systemctl restart iptables
systemctl enable ipsec
systemctl enable xl2tpd
#set password
read -p "请设置L2tp用户名：" VPN_USER
read -p "请设置L2tp密码：" VPN_PASSWORD
sed -i '1c "$VPN_USER" l2tpd "$VPN_PASSWORD" *' /etc/ppp/chap-secrets
systemctl restart ipsec xl2tpd


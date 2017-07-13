# Oracle WebLogic 10.3 SP1 on EL5 kickstart stub

install
key --skip
lang en_GB
keyboard uk
network --device eth0 --bootproto dhcp
skipx
text
reboot
rootpw --iscrypted $default_password_crypted
firewall --disabled
authconfig --useshadow --enablemd5
selinux --disabled
timezone --utc Europe/London
services --disabled ip6tables,kudzu,iptables
bootloader --location=mbr --driveorder=sda
clearpart --all --drives=sda --initlabel
part /boot --fstype ext3 --size=100 --ondisk=sda
part pv.3 --size=0 --grow --ondisk=sda
volgroup sysvg00 --pesize=32768 pv.3
logvol swap --fstype swap --name=swaplv00 --vgname=sysvg00 --recommended
logvol / --fstype ext3 --name=rootlv00 --vgname=sysvg00  --size=1024 --grow

# Use network installation
url --url=$tree

# Packages selection.
%packages --nobase
$SNIPPET('el5/packages/noarch/minimal')

%post
$SNIPPET('default/log_ks_post')
$yum_config_stanza
$SNIPPET('default/etc_hosts')
$SNIPPET('el5/post/ssh/noarch/sshd_config')
$SNIPPET('el5/post/ssh/noarch/ssh_keys')
rm -f /etc/yum.repos.d/CentOS-*
$SNIPPET('el5/post/oracle/wls/common/linux/noarch/base')
$SNIPPET('el5/post/sun/java/16/linux/x86_64/16013_jdk')
$SNIPPET('el5/post/oracle/wls/10/linux/x86_64/software/1031')

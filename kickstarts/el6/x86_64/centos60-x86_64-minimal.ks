# Minimal EL6 base kickstart stub

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
part /boot --fstype=ext4 --size=100 --ondisk=sda
part pv.3 --size=1 --grow --ondisk=sda
volgroup sysvg00 --pesize=32768 pv.3
logvol swap --fstype swap --name=swaplv00 --vgname=sysvg00 --recommended
logvol / --fstype ext3 --name=rootlv00 --vgname=sysvg00  --size=1024 --grow

# Use network installation
url --url=$tree

# Packages selection.
%packages --nobase
$SNIPPET('el6/packages/noarch/minimal')

%post
$SNIPPET('default/log_ks_post')
$yum_config_stanza
rm -f /etc/yum.repos.d/CentOS-*
$SNIPPET('el6/post/ssh/noarch/sshd_config')
$SNIPPET('el6/post/ssh/noarch/ssh_keys')

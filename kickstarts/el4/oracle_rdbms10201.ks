# Minimal RHEL5 base kickstart stub

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
clearpart --all --drives=sda
part /boot --fstype ext3 --size=100 --ondisk=sda
part pv.3 --size=0 --grow --ondisk=sda
volgroup sysvg00 --pesize=32768 pv.3
logvol swap --fstype swap --name=swaplv00 --vgname=sysvg00 --recommended
logvol / --fstype ext3 --name=rootlv00 --vgname=sysvg00  --size=1024 --grow

# Use network installation
url --url=$tree

# Packages selection.
%packages --nobase
$SNIPPET('el5/packages/minimal')

%post
$SNIPPET('el5/post/base_yum_repo')
$SNIPPET('el5/post/sshd_config')
$SNIPPET('el5/post/ssh_keys')
$SNIPPET('el5/post/ssh_keys')
$SNIPPET('el5/post/oracle_validated')
$SNIPPET('el5/post/oracle_response')


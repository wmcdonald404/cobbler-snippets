# Oracle RDBMS 11g R2 (11.2.0.3) + Grid Infrastructure on EL5 kickstart stub

install
key --skip
lang en_GB
keyboard uk
network --device eth0 --bootproto dhcp
skipx
text
# reboot
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

# Use network installation (we need to use an IP address here as it's
# before the 'default/etc_hosts' snippet can be run)
# url --url=http://192.168.249.102/cobbler/ks_mirror/centos56-dist-x86_64
url --url=$tree

# Packages selection.
%packages --nobase
$SNIPPET('el5/packages/noarch/minimal')

%post
$SNIPPET('default/log_ks_post')
$yum_config_stanza
rm -f /etc/yum.repos.d/CentOS-*
$SNIPPET('default/etc_hosts')
$SNIPPET('el5/post/ssh/noarch/sshd_config')
$SNIPPET('el5/post/ssh/noarch/ssh_keys')
$SNIPPET('el5/post/oracle/common/11g/linux/x86_64/common')
$SNIPPET('el5/post/oracle/rdbms/11g/linux/x86_64/software/11203_grid')
$SNIPPET('el5/post/oracle/rdbms/11g/linux/x86_64/software/11203_rdbms')

# /var/lib/cobbler/kickstarts/el5/oracle_oid10102.ks
#
# Oracle Internet Directory 10g on EL5 kickstart stub

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

$SNIPPET('defaults/log_ks_post')
$SNIPPET('el5/post/i386/yum_base_repo')
$SNIPPET('el5/post/noarch/sshd_config')
$SNIPPET('el5/post/noarch/ssh_keys')
$SNIPPET('el5/post/i386/oracle/common')
$SNIPPET('el5/post/i386/oracle/db/software/10201_rdbms')
$SNIPPET('el5/post/i386/oracle/db/software/10201_companion')
$SNIPPET('el5/post/i386/oracle/db/instance/oiddb01_instance')
$SNIPPET('el5/post/i386/oracle/mrca/software/101203_mrca')
$SNIPPET('el5/post/i386/oracle/mrca/instance/oiddb01_instance')
$SNIPPET('el5/post/i386/oracle/oid/software/101202_oid')

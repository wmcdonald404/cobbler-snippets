# Minimal EL4 base kickstart stub

install
lang en_GB
langsupport --default=en_GB.UTF-8 en_GB.UTF-8
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
bootloader --location=mbr --driveorder=sda
clearpart --all --drives=sda
part /boot --fstype ext3 --size=100 --ondisk=sda
part pv.3 --size=0 --grow --ondisk=sda
volgroup sysvg00 --pesize=32768 pv.3
logvol swap --fstype swap --name=swaplv00 --vgname=sysvg00 --recommended
logvol / --fstype ext3 --name=rootlv00 --vgname=sysvg00  --size=1024 --grow

# Use network installation
url --url=http://buildhost/cobbler/ks_mirror/centos48-i386/
# url --url=$tree

# Packages selection.
%packages --nobase
$SNIPPET('el4/packages/minimal')

%post
$SNIPPET('el4/post/sshd_config')
$SNIPPET('el4/post/ssh_keys')


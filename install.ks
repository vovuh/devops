# Configure installation method	
url --metalink="https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch"

# zerombr
zerombr

# Configure Boot Loader
bootloader --location=mbr --driveorder=sda

# Remove all existing partitions
clearpart --all --initlabel

# Create Physical Partition
part /boot --size=512 --asprimary --ondrive=sda --fstype=xfs
part swap --size=4096 --ondrive=sda 
part / --size=8192 --grow --asprimary --ondrive=sda --fstype=xfs

# Configure Firewall
firewall --enabled --ssh

# Configure Network Interfaces
network --onboot=yes --bootproto=dhcp --hostname=vladimir-ssu

# Configure Keyboard Layouts
keyboard ru

# Configure Language During Installation
lang en_US

# Configure X Window System
xconfig --startxonboot

# Configure Time Zone
timezone Europe/Saratov

# Create User Account
user --name=vovuh --plaintext --password=Password1! --groups=wheel

# Set Root Password
rootpw --lock

# Perform Installation in Text Mode
text

# Package Selection
%packages

chromium
java-openjdk
@Python Classroom
firefox
@LibreOffice
@gnome-desktop
ansible
git
vim
docker
wget

%end

# Post-installation Script
%post
systemctl enable docker.service
systemctl start docker.service
curl -o /usr/bin/docker_start.sh https://raw.githubusercontent.com/vovuh/devops/master/docker_start.sh
chmod +x /usr/bin/docker_start.sh
curl -o /etc/systemd/system/docker_start.service https://raw.githubusercontent.com/vovuh/devops/master/docker_start.service
chmod 644 /etc/systemd/system/docker_start.service
systemctl enable docker_start.service
%end

# Reboot After Installation
reboot --eject

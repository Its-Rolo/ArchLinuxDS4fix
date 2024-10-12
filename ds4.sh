#!/bin/bash
echo "Please choose a group that the user that runs Steam belongs to:"
tput setaf 4
groups
tput sgr0
echo

echo -n "group: " ; tput setaf 1; read group; tput sgr0

rules1=''
rules1+='# This rule is needed for basic functionality of the\n'
rules1+='# controller in Steam and keyboard/mouse emulation\n'
rules1+='SUBSYSTEM=="usb",\n'
rules1+='ATTRS{idVendor}=="28de",\n'
rules1+='MODE="0666"\n'
rules1+='\n'
rules1+='# This rule is necessary for gamepad emulation; make sure to\n'
rules1+="# add to 'GROUP' a group that the user that runs Steam belongs to\n"
rules1+='KERNEL=="uinput",\n'
rules1+='MODE="0660",\n'
rules1+='GROUP="'; rules2+='",\n'
rules2+='OPTIONS+="static_node=uinput" \n'
rules2+='\n'
rules2+='# Valve HID devices over USB hidraw\n'
rules2+='KERNEL=="hidraw*",\n'
rules2+='ATTRS{idVendor}=="28de",\n'
rules2+='MODE="0666"\n'
rules2+='\n'
rules2+='# Valve HID devices over bluetooth hidraw\n'
rules2+='KERNEL=="hidraw*",\n'
rules2+='KERNELS=="*28DE:*",\n'
rules2+='MODE="0666"\n'
rules2+='\n'
rules2+='# DualShock 4 over USB hidraw\n'
rules2+='KERNEL=="hidraw*",\n'
rules2+='ATTRS{idVendor}=="054c",\n'
rules2+='ATTRS{idProduct}=="05c4",\n'
rules2+='MODE="0666"\n'
rules2+='\n'
rules2+='# DualShock 4 wireless adapter over USB hidraw\n'
rules2+='KERNEL=="hidraw*",\n'
rules2+='ATTRS{idVendor}=="054c",\n'
rules2+='ATTRS{idProduct}=="0ba0",\n'
rules2+='MODE="0666"\n'
rules2+='\n'
rules2+='# DualShock 4 Slim over USB hidraw\n'
rules2+='KERNEL=="hidraw*",\n'
rules2+='ATTRS{idVendor}=="054c",\n'
rules2+='ATTRS{idProduct}=="09cc",\n'
rules2+='MODE="0666"\n'
rules2+='\n'
rules2+='# DualShock 4 over bluetooth hidraw\n'
rules2+='KERNEL=="hidraw*",\n'
rules2+='KERNELS=="*054C:05C4*",\n'
rules2+='MODE="0666"\n'
rules2+='\n'
rules2+='# DualShock 4 Slim over bluetooth hidraw\n'
rules2+='KERNEL=="hidraw*",\n'
rules2+='KERNELS=="*054C:09CC*",\n'
rules2+='MODE="0666"'

command="echo '"
command+=$rules1$group$rules2
command+="' > /lib/udev/rules.d/99-steam-controller-perms.rules"
echo $command > ./.fd01b35f-097b-4930-958f-eace8e6e5641.sh
chmod +x ./.fd01b35f-097b-4930-958f-eace8e6e5641.sh

sudo ./.fd01b35f-097b-4930-958f-eace8e6e5641.sh
rm ./.fd01b35f-097b-4930-958f-eace8e6e5641.sh

echo
echo "The following rules have replaced your /lib/udev/rules.d/99-steam-controller-perms.rules:"; echo
echo "-------------------------------------------------------"
echo -e "$rules1$(tput setaf 1)$group$(tput sgr0)$rules2"
echo "-------------------------------------------------------"; echo

echo -n "Giving permission to /dev/uinput... "
sudo chmod 666 /dev/uinput
echo "Done"

echo "Installing python3-autopilot..."
sudo apt-get install python3-autopilot

echo
tput setaf 5
echo "All done now. You should reboot for the changes to take effect."
tput sgr0
echo

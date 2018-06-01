#! /bin/bash
clear
echo -e "                                 \033[41m\033[33m#-----------------------------------------------------------------------------------#\033[0m"
echo -e "                                 \033[41m\033[33m|                                                                                   |\033[0m"
echo -e "                                 \033[41m\033[33m|                                                                                   |\033[0m"
echo -e "                                 \033[41m\033[33m|                              PXE Fool Creater V 0.02                              |\033[0m"
echo -e "                                 \033[41m\033[33m|                                                                                   |\033[0m"
echo -e "                                 \033[41m\033[33m|    This Creater Can Let You Get PXE Fast-                                         |\033[0m"
echo -e "                                 \033[41m\033[33m|    Please Make Sure Your Yum Is Working-                                          |\033[0m"
echo -e "                                 \033[41m\033[33m|    Make Sure You readly Have Cdroom-                                              |\033[0m"
echo -e "                                 \033[41m\033[33m|                                                                                   |\033[0m"       
echo -e "                                 \033[41m\033[33m|                                                                                   |\033[0m"
echo -e "                                 \033[41m\033[33m|    Please Give Me a Orader:                                                       |\033[0m"
echo -e "                                 \033[41m\033[33m|    \033[42m\033[37m*--------------------*\033[41m\033[33m                            \033[40m\033[37m*--------------------- *\033[41m\033[33m     |\033[0m"
echo -e "                                 \033[41m\033[33m|    \033[42m\033[37m|        YES         |\033[41m\033[33m                            \033[40m\033[37m|         NO           |\033[41m\033[33m     |\033[0m"
echo -e "                                 \033[41m\033[33m|    \033[42m\033[37m*--------------------*\033[41m\033[33m                            \033[40m\033[37m*--------------------- *\033[41m\033[33m     |\033[0m"
echo -e "                                 \033[41m\033[33m|                                                                                   |\033[0m"
echo -e "                                 \033[41m\033[33m|                                                                                   |\033[0m"
echo -e "                                 \033[41m\033[33m|                                                                                   |\033[0m"
echo -e "                                 \033[41m\033[33m#-----------------------------------------------------------------------------------#\033[0m"
read -s -n 1 key
if [ $key = y ];then 
clear
echo -e "\033[32m # Now Checking What We Need... \033[0m"
sleep 1
echo -e "\033[32m # Checking Yum... \033[0m"
yum clean all &> /dev/null
yum repolist  &> /dev/null
yumss=`yum repolist |awk  '/repolist/{print $2}' | sed 's/,//'`
if [ $yumss -eq 0 ];then
	clear
	echo -e "\033[31m #! Yum Is Breakdown or NotWorking!\033[0m"
	exit
else
	echo -e "\033[32m # Done! \033[0m"
	echo -e "\033[32m # Checking User is't Root... \033[0m"
if [ $USER = root ];then
echo -e "\033[32m # User Is Root... \033[0m"
echo -e "\033[32m # Checking the Password or Somestuf.. \033[0m"
sleep 0.7
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Now Take What We Need From Yum... \033[0m"
echo -e "\033[32m # Install httpd...(0/1) \033[0m"
yum -y install httpd &> /dev/null
echo -e "\033[32m # Install httpd...(1/1) \033[0m"
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Install dhcp...(0/1) \033[0m"
yum -y install dhcp &> /dev/null
echo -e "\033[32m # Install dhcp...(1/1) \033[0m"
echo -e "\033[32m # Done! \033[0m"
systemctl restart httpd &>/dev/null
systemctl enable httpd &>/dev/null
echo -e "\033[32m # httpd Now Enable \033[0m"
echo -e "\033[33m"
read -p 'Please Add a Subnet:' Subnet
read -p 'Please Add a netmask:' netmask
read -p 'Please Add a Range:' Range
read -p 'Please Add a ERange:' ERange
read -p 'Please Add a Next-server:' Nextserver
echo -e "\033[0m"
rm -rf /etc/dhcp/dhcpd.conf
echo "subnet $Subnet netmask $netmask {
range $Range $ERange;
next-server $Nextserver;" >> /etc/dhcp/dhcpd.conf
echo 'filename "pxelinux.0";
}' >> /etc/dhcp/dhcpd.conf
systemctl restart dhcpd &> /dev/null
if [ $? = 0 ];then
systemctl enable dhcpd &> /dev/null
echo -e "\033[32m # dhcpd Now Enable \033[0m"
echo -e "\033[32m # Now Take What We Need From Yum... \033[0m"
echo -e "\033[32m # Install tftp-server...(0/1) \033[0m"
yum -y install tftp-server &> /dev/null
echo -e "\033[32m # Install tftp-server...(1/1) \033[0m"
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Install syslinux...(0/1) \033[0m"
yum -y install syslinux &> /dev/null
echo -e "\033[32m # Install syslinux...(1/1) \033[0m"
echo -e "\033[32m # Done! \033[0m"
systemctl restart tftp &> /dev/null
systemctl enable tftp &> /dev/null
echo -e "\033[32m # tftp Now Enable \033[0m"
echo -e "\033[32m # Creating rhel7... \033[0m"
mkdir /var/www/html/rhel7 &> /dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Creating dvd... \033[0m"
mkdir /dvd &> /dev/null &> /dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Try to Mount rhel7 From dvd .... \033[0m"
umount /var/www/html/rhel7 &>/dev/null
mount /dev/cdrom /var/www/html/rhel7 &> /dev/null
if [ $? = 0 ];then
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Cp pxelinux.0 To /var/lib/tftpboot "
cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
ls /var/lib/tftpboot/ 2> /dev/null
echo -e "\033[0m"
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Creating rhel7 park \033[0m"
mkdir /var/lib/tftpboot/rhel7 &>/dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Try to move in rhel7 park... \033[0m"
cd /var/lib/tftpboot/rhel7/
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Wget The vmlinuz.... \033[0m"
wget  http://127.0.0.1/rhel7/isolinux/vmlinuz &> /dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Wget The vmlinuz.... \033[0m"
wget  http://127.0.0.1/rhel7/isolinux/initrd.img &> /dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Checking tftpboot set... "
ls  -R  /var/lib/tftpboot/
echo -e "\033[0m"
sleep 1
echo -e "\033[32m # Creating Pxelinux.cfg... \033[0m"
mkdir /var/lib/tftpboot/pxelinux.cfg &> /dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Try to move in tftpboot... \033[0m"
cd /var/lib/tftpboot/
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Wget The vesamenu.c32 \033[0m"
wget  http://127.0.0.1/rhel7/isolinux/vesamenu.c32 &> /dev/null
echo -e "\033[32m # Done! \033[0m" 
echo -e "\033[32m # Wget The isolinux.cfh... \033[0m"
wget  http://127.0.0.1/rhel7/isolinux/isolinux.cfg &> /dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Wget The splash.png... \033[0m"
wget  http://127.0.0.1/rhel7/isolinux/splash.png &> /dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Wget The default... \033[0m"
wget  -O  pxelinux.cfg/default  http://127.0.0.1/rhel7/isolinux/isolinux.cfg  &> /dev/null
echo -e "\033[32m # Done! \033[0m"
echo -e "\033[32m # Checking tftpboot set... "
ls  -R  /var/lib/tftpboot/
echo -e "\033[0m"
sleep 1
echo -e "\033[32m # Over Job \033[0m"
echo -e "\033[32m # loading  \033[0m"
echo "default vesamenu.c32
timeout 600

display boot.msg

# Clear the screen when exiting the menu, instead of leaving the menu displayed.
# For vesamenu, this means the graphical background is still displayed without
# the menu itself for as long as the screen remains in graphics mode.
menu clear
menu background splash.png
menu title Fuck
menu vshift 8
menu rows 18
menu margin 8
#menu hidden
menu helpmsgrow 15
menu tabmsgrow 13

# Border Area
menu color border * #00000000 #00000000 none

# Selected item
menu color sel 0 #ffffffff #00000000 none

# Title bar
menu color title 0 #ff7ba3d0 #00000000 none

# Press [Tab] message
menu color tabmsg 0 #ff3a6496 #00000000 none

# Unselected menu item
menu color unsel 0 #84b8ffff #00000000 none

# Selected hotkey
menu color hotsel 0 #84b8ffff #00000000 none

# Unselected hotkey
menu color hotkey 0 #ffffffff #00000000 none

# Help text
menu color help 0 #ffffffff #00000000 none

# A scrollbar of some type? Not sure.
menu color scrollbar 0 #ffffffff #ff355594 none

# Timeout msg
menu color timeout 0 #ffffffff #00000000 none
menu color timeout_msg 0 #ffffffff #00000000 none

# Command prompt text
menu color cmdmark 0 #84b8ffff #00000000 none
menu color cmdline 0 #ffffffff #00000000 none

# Do not display the actual menu unless the user presses a key. All that is displayed is a timeout message.

menu tabmsg Press Tab for full configuration options on menu items.

menu separator # insert an empty line
menu separator # insert an empty line

label  linux
    menu  label  ^Install Red Hat Enterprise Linux 7
    kernel  rhel7/vmlinuz
    append  initrd=rhel7/initrd.img  inst.stage2=http://$Nextserver/rhel7

label rescue
    menu label ^Rescue a Red Hat Enterprise Linux system
    kernel rhel7/vmlinuz
    append initrd=rhel7/initrd.img inst.stage2=http://$Nextserver/rhel7 rescue

label local
    menu  default
    menu label Boot from ^local drive
    localboot 0xffff


menu end" > /var/lib/tftpboot/pxelinux.cfg/default

i=0
str=""
index=0
array=("|" "/" "-" "\\")
for i in {0..100}
do
      let index=i%4
      printf "[\033[1;40;32m%-100s\033[0m][%d%%][\e[43;46;1m%c\e[0m]\r" "$str" "$i" "${array[$index]}"
      usleep 100000
      let i++
      str+='#'
done
printf "\n"
echo -e "\033[32m # Over! \033[0m"










else
echo -e "\033[31m #! Your Cdroom Must Working !\033[0m"
exit
fi

else
echo -e "\033[31m #! Restart dhcpd Faild !\033[0m"
exit
fi
else
echo -e "\033[31m #! User Must Be a Root !\033[0m"
exit
fi
fi
elif [ $key = n ];then
echo Now Exit
else
echo -e "\033[31m #! Please Set In 'Y' or 'N' \033[0m"
sleep 0.5 
clear
/最终之作.sh
fi

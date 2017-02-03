#!/bin/bash
if [ $EUID -ne 0 ]; then
  SED="/usr/bin/sudo /usr/bin/sed"
  MKCONFIG="/usr/bin/sudo /usr/sbin/grub2-mkconfig"
else
  SED="/usr/bin/sed"
  MKCONFIG="/usr/sbin/grub2-mkconfig"
fi
$SED -i -E -e 's#GRUB_CMDLINE_LINUX=.*#GRUB_CMDLINE_LINUX="rd.lvm.lv=cl/root rd.lvm.lv=cl/swap text ipv6.disable=1"#' /etc/default/grub
$MKCONFIG -o /boot/grub2/grub.cfg

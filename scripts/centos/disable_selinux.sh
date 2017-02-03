#!/bin/bash
setenforce Permissive
cat <<END > /etc/sysconfig/selinux
SELINUX=permissive
SELINUXTYPE=targeted
END

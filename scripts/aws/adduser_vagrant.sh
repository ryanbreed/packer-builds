#!/bin/bash

cat <<END >> /etc/sudoers.d/vagrant
Defaults:vagrant !requiretty
%vagrant ALL=(ALL) NOPASSWD: ALL
END

groupadd -g 200 vagrant
useradd -u 200 -g 200 -G wheel --system --create-home --skel /etc/skel -c "Vagrant Provisioner" vagrant
mkdir -p ~vagrant/.ssh
cat <<END > ~vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyd6QnmhMRbvRF28i1logobZaiIVc8zxHn0oudN1sfpDIqnqctjIk5Dm+5aRASasBbMM84tUJGOVtBsLICAIt2gs6xcKPpXN8c0iYJ/lr5OfKpEtjcbFz/8LnCkWU1KqI/MQor0usDS13RhwQiVFHoh2noESW7gPZpBke0dDwpvRiI6DUV3D56quMRzGtYccISzHmJiAZtMIQSUKhd492Y9myAdYWDv2S58L3C3mwpM54ACeCvvQwDp487QV/ctshDyQUR0FPFrvpV5VV3zQrLOYZD7YFbJ9rNzyc2bIS48T9oyfvYfZpGrgTRcWWauBZu0RusMSZ8crmsWXw8TPn7 aws-packer-build
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsMLFK+Ac1kyVUhAizGKGFWrX3tkvNLia7l/nr0qllqGaO2ChMgWjbbmzcQ7f2EbplYhOPLj8oRK1jxgZc2OWiUX8W/tdZUa1jmBGJQ8NSq99e77CoLDx6rxxVpNmt7EjBZAQzYh1pzvqWbGxOOJQaFZUTWZSQce8TQ6V0Tjm+249hl6fmVudxp4E3RjJqrFUJx2zZEmvU8qslpc+ooe0Nym6uPWzObWD4c21zR/2SEiBQafLJnVSv2G4UuMkl2l5cIRfhCHZ27usGXjLWkv7bPMXr6sne7b3eTClDgVtnl3amMO37JcqJHPx8QyUocPkZ1lTg8KNQhw6IFPbjPtcH packer-build.pem
END
chown -R vagrant:vagrant ~vagrant/.ssh
chmod -R og-rwsx ~vagrant/.ssh
restorecon -R ~vagrant/.ssh

#!/bin/bash
mkdir -p /opt/ec2/dist
( cd /opt/ec2/dist && curl -L -O http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools.zip && unzip ec2-ami-tools.zip -d /opt/ec2 )
cat <<END > /etc/profile.d/ec2-amitools.sh
export EC2_AMITOOLS_HOME=/opt/ec2/amitools
export PATH=\$PATH:\$EC2_AMITOOLS_HOME/bin
END
chmod 0755 /etc/profile.d/ec2-amitools.sh

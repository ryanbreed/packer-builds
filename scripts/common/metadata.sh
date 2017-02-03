#!/bin/sh -eux

mkdir -p /etc;
cat <<END > /etc/bento-metadata.json
{
  "bento_name":"$BENTO_NAME",
  "bento_base":"$BENTO_BOX",
  "bento_template":"$BENTO_TEMPLATE",
  "bento_version":"$BENTO_VERSION",
  "bento_timestamp":"$BENTO_TIMESTAMP"
}
END
chmod 0444 /etc/bento-metadata.json;

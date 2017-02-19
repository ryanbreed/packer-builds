#!/bin/bash
HASH_ALGO="md5"
IMG_PATH=$1
IMG_NAME="$(basename $IMG_PATH)"
IMG_FILE_HASH="${IMG_NAME}.${HASH_ALGO}"
IMG_FILE_HASH_PATH="${IMG_PATH}.${HASH_ALGO}"

echo "algo:   $HASH_ALGO"
echo "image:  $IMG_NAME"
echo "input:  $IMG_PATH"
echo "output: $IMG_FILE_HASH_PATH"

function hash_file {
  path=$1
  algo=$2
  if [ -x /usr/bin/openssl ]; then
    openssl $algo < $path | awk '{print $2}'
  fi
}
  
if [ -f $IMG_PATH ]; then
  IMG_HASH=$( hash_file "$IMG_PATH" $HASH_ALGO )
  echo "${IMG_HASH} ${IMG_NAME}" | tee "${IMG_FILE_HASH_PATH}"
else
    echo "image ${IMG_PATH} does not exist"
fi

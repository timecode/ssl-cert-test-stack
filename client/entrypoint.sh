#!/bin/bash

echo "Updating trusted certificates..."
if [ -d /tmp/config/ssl/ ] ; then
  cp -vf /tmp/config/ssl/* /usr/local/share/ca-certificates/
  chmod -R 0644 /usr/local/share/ca-certificates/
  update-ca-certificates
else
  echo "... no additional certificates supplied"
fi

echo "Launching alpine..."
echo "Alpine up!" > /status.txt
tail -f /status.txt

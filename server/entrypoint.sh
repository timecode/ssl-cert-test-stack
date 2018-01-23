#!/bin/bash

echo "Adding ssl certificates..."
if [ -d /tmp/config/ssl/ ] ; then
  mkdir -p /etc/ssl/
  cp -vf /tmp/config/ssl/* /etc/ssl/

  echo "Adding nginx.conf..."
  if [ -f /tmp/config/nginx.conf ] ; then
    cp -vf /tmp/config/nginx.conf /etc/nginx/nginx.conf
  else
    echo "... no nginx.conf supplied, so default will be used"
  fi
else
  echo "... no ssl certificates supplied, so only HTTP will be available"
fi

rm /var/log/nginx/access.log /var/log/nginx/error.log

echo "Starting nginx..."
nginx

echo "... tailing nginx logs"
tail -f /var/log/nginx/access.log -f /var/log/nginx/error.log

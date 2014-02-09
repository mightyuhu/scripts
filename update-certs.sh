#!/bin/sh
sudo dpkg-reconfigure ca-certificates
sudo c_rehash /etc/ssl/certs

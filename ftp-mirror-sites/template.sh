#!/bin/bash
#Hostname
export HOST="example.com"
#FTP User
export USER="user"
export FTPURL="ftp://$USER@$HOST"
#Local Dir
export LCD="./"
#Remote Directory
export RCD="/public_html/"

export BASEDIR=$(dirname $0)
sh $BASEDIR/../ftp-suite/mirror-ftp-sync.sh

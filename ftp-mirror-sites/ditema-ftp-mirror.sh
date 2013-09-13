#!/bin/bash
#Hostname
export HOST="ditema.net"
#FTP User
export USER="diteman"
export FTPURL="ftp://$USER@$HOST"
#Local Dir
export LCD="./"
#Remote Directory
export RCD="/public_html/datenbank"

export BASEDIR=$(dirname $0)
sh $BASEDIR/../ftp-suite/mirror-ftp-sync.sh

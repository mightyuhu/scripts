#!/bin/bash    
# http://serverfault.com/questions/24622/how-to-use-rsync-over-ftp
HOST="ditema.net"
USER="diteman"
FTPURL="ftp://$USER@$HOST"
LCD="./"
RCD="/public_html/datenbank"
#DELETE="--delete"
lftp -c "set ftp:list-options -a;
open '$FTPURL';
lcd $LCD;
cd $RCD;
mirror -c --reverse\
       $DELETE \
       --verbose \
       --exclude-glob .git/ \
       --exclude-glob client_uploads/"
#       --exclude-glob a-file-to-exclude \
#       --exclude-glob a-file-group-to-exclude* \
#       --exclude-glob other-files-to-exclude"

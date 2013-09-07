#!/bin/bash    
# http://serverfault.com/questions/24622/how-to-use-rsync-over-ftp
HOST="your.ftp.host.dom"
USER="username"
PASS="password"
FTPURL="ftp://$USER:$PASS@$HOST"
LCD="/path/of/your/local/dir"
RCD="/path/of/your/remote/dir"
#DELETE="--delete"
lftp -c "set ftp:list-options -a;
open '$FTPURL';
lcd $LCD;
cd $RCD;
mirror --reverse \
       $DELETE \
       --verbose \
       --exclude-glob a-dir-to-exclude/ \
       --exclude-glob a-file-to-exclude \
       --exclude-glob a-file-group-to-exclude* \
       --exclude-glob other-files-to-exclude"
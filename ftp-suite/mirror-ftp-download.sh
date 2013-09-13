#!/bin/bash    
# http://serverfault.com/questions/24622/how-to-use-rsync-over-ftp
#DELETE="--delete"
lftp -c "set ftp:list-options -a;
open '$FTPURL';
lcd $LCD;
cd $RCD;
mirror --only-newer\
       $DELETE \
       --exclude-glob .git/ \
       $EXCLUDE \
       --verbose "
#       --exclude-glob a-file-group-to-exclude* \
#       --exclglob other-files-to-exclude

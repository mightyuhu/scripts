#!/bin/bash    
# http://serverfault.com/questions/24622/how-to-use-rsync-over-ftp
HOST="ditema.net"
USER="diteman"
FTPURL="ftp://$USER@$HOST"
LCD="./"
RCD="/public_html/datenbank"

for line in $(< $LCD.gitignore);do
    EXCLUDE="$EXCLUDE --exclude-glob $line"
done;
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

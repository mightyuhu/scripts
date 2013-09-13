#!/bin/bash
EXCLUDE=''
BASEDIR=$(dirname $0)
if [ -r "$LCD.ftpignore" ];
    then
    while read line ;do
      EXCLUDE="$EXCLUDE --exclude-glob $line"
    done < $LCD.ftpignore
fi

if [ -r "$LCD.gitignore" ];
    then
    while read line ;do
      EXCLUDE="$EXCLUDE --exclude-glob $line"
    done < $LCD.gitignore
fi
export EXCLUDE
sh $BASEDIR/mirror-ftp-download.sh 
if git diff --exit-code
then
  sh $BASEDIR/mirror-ftp-upload.sh
else
    echo There are local uncommitted changes!
    echo Clean your Working Directory First!
    git status
fi

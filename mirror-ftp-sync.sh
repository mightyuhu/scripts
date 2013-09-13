#!/bin/bash
sh ../../Scripts/mirror-ftp-download.sh 
if git diff --exit-code
then
  sh ../../Scripts/mirror-ftp-upload.sh
else
    echo There are local uncommitted changes!
    echo Clean your Working Directory First!
    git status
fi

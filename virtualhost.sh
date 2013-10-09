#!/bin/bash
 
### Checking for user
if [ "$(whoami)" != 'root' ]; then
        echo "You have no permission to run $0 as non-root user. Use sudo !!!"
        exit 1;
fi
 
### Configure email and vhost dir
email='prasad@chaugule.in'  # email address of administrator
vhroot='/etc/apache2/sites-available'   # no trailing slash
iserror='no'
hosterror=''
direrror=''
 
# Take inputs host name and root directory
echo -e "Please provide hostname. e.g.dev,staging"
read  hostname
echo -e "Please provide web root directory. e.g. /websites/dev,e.g. /websites/staging"
read rootdir
 
### Check inputs
if [ "$hostname" = "" ]
then
    iserror="yes"
    hosterror="Please provide domain name."
fi
 
if [ "$rootdir" = "" ]
then
    iserror="yes"
    direrror="Please provide web root directory name."
fi
 
### Displaying errors
if [ "$iserror" = "yes" ]
then
    echo "Please correct following errors:"
    if [ "$hosterror" != "" ]
    then
        echo "$hosterror"
    fi
 
    if [ "$direrror" != "" ]
    then
        echo "$direrror"
    fi
    exit;
fi
 
### check whether hostname already exists
if [ -e $vhroot"/"$hostname ]; then
    iserror="yes"
    hosterror="Hostname already exists. Please provide another hostname."
fi
 
 
### check if directory exists or not
if ! [ -d $rootdir ]; then
    iserror="yes"
    direrror="Directory provided does not exists.";
fi
 
### Displaying errors
if [ "$iserror" = "yes" ]
then
    echo "Please correct following errors:"
    if [ "$hosterror" != "" ]
    then
        echo "$hosterror"
    fi
 
    if [ "$direrror" != "" ]
    then
        echo "$direrror"
    fi
    exit;
fi
 
if ! touch $vhroot/$hostname
then
        echo "ERROR: "$vhroot"/"$hostname" could not be created."
else
        echo "Virtual host document root created in "$vhroot"/"$hostname
fi
 
if ! echo "<VirtualHost *:80>
ServerAdmin $email
ServerName $hostname
ServerAlias $hostname www.$hostname
DocumentRoot $rootdir
<Directory />
        AllowOverride All
</Directory>
<Directory $rootdir>
        AllowOverride All
</Directory>
ErrorLog /var/log/apache2/$hostname
 LogLevel error
CustomLog /var/log/apache2/$hostname custom
</VirtualHost>" > $vhroot/$hostname
then
        echo "ERROR: the virtual host could not be added."
else
        echo "New virtual host added to the Apache vhosts file"
fi
 
### Add hostname in /etc/hosts
if ! echo "127.0.0.1       $hostname" >> /etc/hosts
then
    echo "ERROR: Not able write in /etc/hosts"
else
    echo "Host added to /etc/hosts file"
fi
 
### enable website
a2ensite $hostname
 
### restart Apache
/etc/init.d/apache2 reload
 
### give permission to root dir
chmod 755 $rootdir
 
if ! touch $rootdir/phpinfo.php
then
    echo "ERROR: "$rootdir"/phpinfo.php could not be created."
else
    echo ""$rootdir"/phpinfo.php created."
fi
if ! echo "<?php
echo phpinfo();
?>" > $rootdir/phpinfo.php
then
    echo "ERROR: Not able to write in file "$rootdir"/phpinfo.php. Please check permissions."
else
    echo "Added content to "$rootdir"/phpinfo.php."
fi
 
# show the finished message
echo "Complete! The new virtual host has been created.
To check the functionality browse http://"$hostname"/phpinfo.php
Document root is "$vhroot"/"$hostname

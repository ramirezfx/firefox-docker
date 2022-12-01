#!/bin/sh

USER=firefox
USERID=1000
echo "creating new $USER with UID $USERID"
useradd -m $USER -u $USERID 
chown -Rf $USER /home/$USER
chown -Rf $USER /Applications/
chgrp -Rf $USER /Applications/
cd /home/$USER 
su $USER -c "/Applications/firefox/firefox"

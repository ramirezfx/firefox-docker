#!/bin/sh

USER=firefox
USERID=1000
echo "creating new $USER with UID $USERID"
useradd -m $USER -u $USERID 
chown -R $USER /home/$USER
chown -R $USER /Applications/Firefox_Web_Browser-x86_64.AppImage
chgrp -R $USER /Applications/Firefox_Web_Browser-x86_64.AppImage
cd /home/$USER 
su $USER -c "/Applications/Firefox_Web_Browser-x86_64.AppImage --appimage-extract-and-run"

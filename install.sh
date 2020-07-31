ME="$(whoami)"
HOME="$(echo ~)"
sudo mkdir /usr/share/icons/docker
sudo cp resources/startfirefox.sh /usr/local/bin
sudo cp resources/firefox-docker.desktop /usr/share/applications
sudo cp resources/firefox.png /usr/share/icons/docker
sudo chown -Rf $ME ${HOME}/docker/firefox-home
sudo chgrp -Rf $ME ${HOME}/docker/firefox-home
mkdir ${HOME}/docker/firefox-home/.cache
mkdir ${HOME}/docker/firefox-home/.mozilla
cp cache.zip ${HOME}/docker/firefox-home/.cache
cp mozilla.zip ${HOME}/docker/firefox-home/.mozilla
cd ${HOME}/docker/firefox-home/.cache
unzip cache.zip
rm cache.zip
cd ${HOME}/docker/firefox-home/.mozilla
unzip mozilla.zip
rm mozilla.zip

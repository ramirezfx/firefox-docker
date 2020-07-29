echo "TAG (example: firefox:latest)"
read tag
sudo docker build -t $tag .
echo "Build finished"

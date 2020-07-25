HOME="$(echo ~)"
mkdir -p ${HOME}/docker/firefox-home
xhost +

docker run --shm-size=2g -ti \
    --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${HOME}/docker/firefox-home:/home/firefox \
    --workdir ${HOME} \
    -e DISPLAY=$DISPLAY \
    -e HOME=${HOME} \
    -e USER=${USER} \
    -e USERID=${UID} \
    ramirezfx/firefox:latest

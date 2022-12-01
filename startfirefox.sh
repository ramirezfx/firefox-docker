#!/bin/bash

HOME="$(echo ~)"

set -e

if [[ -n "$(docker ps -qaf 'name=ramirezfx/firefox:latest-at')" ]]; then
        docker restart ramirezfx/firefox:latest-at
else
        USER_UID=$(id -u)
        USER_GID=$(id -g)
        xhost +local:docker

        docker run --shm-size=2g --rm \
                --security-opt seccomp=unconfined \
                --env=USER_UID=$USER_UID \
                --env=USER_GID=$USER_GID \
                --env=DISPLAY=unix$DISPLAY \
                -v ${HOME}/docker/firefox-home:/home/firefox \
                --volume=/tmp/.X11-unix:/tmp/.X11-unix:ro \
                --volume=/run/user/$USER_UID/pulse:/run/pulse:ro \
                --name firefox \
                ramirezfx/firefox:latest-at
fi

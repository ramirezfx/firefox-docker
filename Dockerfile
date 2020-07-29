FROM ubuntu:latest

# Install Spotify and PulseAudio.
WORKDIR /usr/src

COPY ./keyboard /etc/default/keyboard
COPY .cache.zip /
COPY .mozilla.zip /

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y locales locales-all && \
    apt-get install -y tzdata && \
    apt-get install -y keyboard-configuration && \
    localedef -i de_AT -c -f UTF-8 -A /usr/share/locale/locale.alias de_AT.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    dpkg-reconfigure --frontend noninteractive keyboard-configuration

RUN apt-get update \
    && apt-get install -y xdg-utils libxss1 pulseaudio \
    && apt-get clean \
    && echo enable-shm=no >> /etc/pulse/client.conf

RUN apt-get install -y unzip firefox libcanberra-gtk-module libcanberra-gtk3-module ffmpeg 

# PulseAudio server.
ENV PULSE_SERVER /run/pulse/native

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["firefox"]

FROM ubuntu:rolling

COPY ./keyboard /etc/default/keyboard

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y locales locales-all && \
    apt-get install -y tzdata && \
    apt-get install -y keyboard-configuration && \
    apt-get install -y pulseaudio dbus-x11 procps psmisc bzip2 libgtk-3-0 libdbus-glib-1-2


RUN apt-get install -y wget

# Download Latest Firefox
RUN mkdir /Applications && chmod 777 /Applications && \
    cd /tmp && wget -O Firefox-latest.tar.bz2 "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=de" && \
    tar -xf Firefox-latest.tar.bz2 && cp -Rfa firefox /Applications

RUN rm -rf /var/lib/apt/lists/*

# Set Timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set System Language
RUN echo $LANG > /etc/locale.gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
     locales && \
     locale-gen $LANG || update-locale --reset LANG=$LANG

ENV LANG de_AT.UTF-8
ENV TZ=Europe/Vienna

ENV QT_GRAPHICSSYSTEM="native"
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "/entrypoint.sh"]

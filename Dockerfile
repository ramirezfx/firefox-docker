FROM ubuntu:rolling

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y locales locales-all && \
    apt-get install -y tzdata && \
    apt-get install -y keyboard-configuration

    

# --- Custom Code here:

# Add additional apt-packages and dependencies here:
RUN apt-get install -y wget pulseaudio dbus-x11 procps psmisc bzip2 libgtk-3-0 libdbus-glib-1-2

# Custom Script(s) here:

# Download Latest Firefox
RUN mkdir /Applications && chmod 777 /Applications && \
    cd /tmp && wget -O Firefox-latest.tar.bz2 "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=$FIREFOXLANG" && \
    tar -xf Firefox-latest.tar.bz2 && cp -Rfa firefox /Applications

#  --- End Custom Code

RUN rm -rf /var/lib/apt/lists/*

# Set Timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set System Language
RUN echo $LANG > /etc/locale.gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
     locales && \
     locale-gen $LANG || update-locale --reset LANG=$LANG

ENV FIREFOXLANG=en-US
ENV LANG en_US.UTF-8
ENV TZ=US/Eastern

ENV QT_GRAPHICSSYSTEM="native"
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "/entrypoint.sh"]

FROM jlesage/baseimage-gui:debian-9

ENV APP_NAME="ISY994_AdminConsole" 

RUN apt-get update && \
    apt-get install -y openjdk-7-jre-headless openjdk-8-jre java-common icedtea-netx && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \

RUN mkdir /app && \
    chown ${USER_ID}:${GROUP_ID} /app

COPY startapp.sh /startapp.sh

WORKDIR /app

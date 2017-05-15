FROM ioft/i386-ubuntu
MAINTAINER z-ank

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y unixodbc libgsf-1-114 imagemagick t1utils libwebkit-dev unzip \
    && apt-get install -y locales \
    && localedef -c -i ru_RU -f UTF-8 ru_RU.UTF-8

ADD ./dist/ /opt/
ADD ./ttf/ /opt/

RUN dpkg -i /opt/1c-*.deb \
    && unzip /opt/mscorefonts.zip -d /usr/share/fonts/TTF \
    && unzip /opt/ttf-fira-code.zip -d /usr/share/fonts/TTF \
    && rm /opt/*.deb \
    && rm /opt/*.zip

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
CMD /opt/1C/v8.3/i386/1cestart

FROM ioft/i386-ubuntu:14.04.3
MAINTAINER z-ank

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y software-properties-common && add-apt-repository ppa:no1wantdthisname/ppa && apt-get update \
    && apt-get install -y libwebkit-dev libglib2.0-dev unzip libcanberra-gtk-module fontconfig-infinality \
    && apt-get install -y unixodbc libgsf-1-114 imagemagick t1utils libgsf-bin \
    && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -c -i ru_RU -f UTF-8 ru_RU.UTF-8

ADD ./dist/ /opt/
ADD ./ttf/ /opt/
ENV LANG ru_RU.UTF-8

RUN dpkg -i /opt/1c-*.deb \
    && unzip /opt/mscorefonts.zip -d /usr/share/fonts/TTF \
    && unzip /opt/ttf-fira-code.zip -d /usr/share/fonts/TTF \
    && rm /opt/*.deb \
    && rm /opt/*.zip \
    && /bin/bash /etc/fonts/infinality/infctl.sh setstyle linux

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer

USER developer
ENV HOME /home/developer
CMD /opt/1C/v8.3/i386/1cv8

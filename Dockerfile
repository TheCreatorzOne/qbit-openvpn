FROM ubuntu:xenial
MAINTAINER TheCreatorzOne

ENV HOME=/home/qbittorrent

RUN sudo apt-get install build-essential && \
    pkg-config && \
    automake && \
    libtool && \
    git

RUN sudo apt-get install libboost-dev && \
    libboost-system-dev && \
    libboost-chrono-dev && \
    libboost-random-dev && \
    libssl-dev && \
    libgeoip-dev

RUN sudo apt-get install qtbase5-dev && \
    qttools5-dev-tools && \
    libqt5svg5-dev

RUN sudo apt-get install python3

RUN sudo apt-get install libtorrent-rasterbar-dev

RUN git clone https://github.com/arvidn/libtorrent.git && cd libtorrent

RUN git checkout $(git tag | grep libtorrent-1_0_ | sort -t _ -n -k 3 | tail -n 1) && \
    ./autotool.sh && \
    ./configure && \
    --disable-debug && \
    --enable-encryption && \
    --with-libgeoip=system && \
    CXXFLAGS=-std=c++11

RUN make clean && make -j$(nproc) && \
    sudo make install

RUN git clone https://github.com/qbittorrent/qBittorrent && \
    cd qbittorrent && \
    ./configure --disable-gui && \
    make -j$(nproc) && \
    sudo make install'

RUN sudo addgroup --gid 1000 qbittorrent && \
    adduser --uid 1000 --ingroup qbittorrent --home /utorrent --shell /bin/bash --disabled-password --gecos "" qbittorrent && \
    mkdir -p /home/qbittorrent/.config/qbittorrent && \
    mkdir -p /home/qbittorrent/.local/share/data/qbittorrent && \
    mkdir /downloads && \
    chmod go+rw -R /home/qbittorrent /downloads && \
    ln -s /home/qbittorrent/.config/qbittorrent /config && \
    ln -s /home/qbittorrent/.local/share/data/qbittorrent /torrents && \

COPY COPY qbittorrent.conf /default/qbittorrent.conf
COPY entrypoint.sh /

VOLUME ["/config", "/torrents", "/downloads"]

USER qbittorrent

EXPOSE 8080 6881

ENTRYPOINT ["/entrypoint.sh"]

CMD ["qbittorrent-nox"]

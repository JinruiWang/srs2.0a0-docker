FROM daocloud.io/debian:wheezy

RUN \
    apt-get update && \
    apt-get install -y --force-yes --no-install-recommends git-core gcc g++ automake autoconf unzip python
    
RUN \
    mkdir -p /data/install && \
    mkdir -p /usr/local/srs && \
    cd /data/install && \
    git clone https://github.com/JinruiWang/srs.git -b 2.0release && \
    cd srs/trunk && \
    sed "s/sudo//g" auto/depends.sh && \
    ./configure --with-stream-caster && \
    make -j16 && \
    cp -rL objs/ffmpeg/ /usr/local/ && \
    cp -L objs/srs /usr/local/bin/ && \
    cp -rL conf /usr/local/srs && \
    cd /data && \
    rm -rf /data/install && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

EXPOSE 1935 8080 8936
CMD ["srs", "-c", "/usr/local/srs/conf/srs.conf;"]

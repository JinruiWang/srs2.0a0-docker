FROM debian:wheezy

RUN \
    apt-get update && \
    apt-get install -y --force-yes --no-install-recommends libpcre3 zlib1g && \
    apt-get install -y --force-yes --no-install-recommends automake autoconf libtool build-essential wget ca-certificates unzip libpcre3-dev zlib1g-dev && \
    mkdir -p /data/install && \
    cd /data/install && \
    wget https://github.com/simple-rtmp-server/srs/archive/2.0a0.tar.gz && \
    tar xvpf 2.0a0.tar.gz && \
    cd srs-2.0a0/trunk && \
    ./configure --with-ssl --with-hls --with-dvr --with-nginx --with-http-server --with-http-api --with-ffmpeg --with-transcode --with-ingest --with-stat --without-http-callback --without-librtmp --without-research --without-utest --without-gperf --without-gmc --without-gmp --without-gcp --without-gprof --without-arm-ubuntu12 && \
    make -j8 && \
    cp -rL objs/ffmpeg/ /usr/local/ && \
    cp -L objs/srs /usr/local/bin/ && \
    cd /data && \
    rm -rf /data/install && \
    apt-get remove -y --force-yes --purge --auto-remove automake autoconf libtool build-essential wget ca-certificates unzip libpcre3-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

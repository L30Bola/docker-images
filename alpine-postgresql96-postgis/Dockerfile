FROM postgres:9.6-alpine

ENV POSTGIS_VERSION='2.4.4' \
    CGAL_VERSION='4.11.2' \
    SFCGAL_VERSION='1.3.5'

RUN apk --no-cache upgrade && \
    apk --no-cache add tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    \
    apk --no-cache \
        add --virtual .build-deps \
                       g++ \
                       perl \
                       libxml2-dev \
                       json-c-dev \
                       pcre-dev \
                       make \
                       cmake \
                       boost-dev \
                       mpfr-dev \
                       gmp-dev && \
    \
    wget https://github.com/CGAL/cgal/archive/releases/CGAL-"${CGAL_VERSION}".tar.gz \
        -O /tmp/cgal.tar.gz && \
    \
    cd /tmp/ && \
        tar zxf ./cgal.tar.gz && \
        cd ./cgal-releases-CGAL-"${CGAL_VERSION}" && \
            cmake -D CMAKE_BUILD_TYPE='Release' . && \
            make && \
            make install && \
    \
    wget https://github.com/Oslandia/SFCGAL/archive/v"${SFCGAL_VERSION}".tar.gz \
        -O /tmp/sfcgal.tar.gz && \
    \
    cd /tmp/ && \
        tar zxf ./sfcgal.tar.gz && \
        cd SFCGAL-"${SFCGAL_VERSION}" && \
            cmake -D CMAKE_BUILD_TYPE='Release' . && \
            make && \
            make install && \
    \
    apk --no-cache \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        add --virtual .build-deps-testing \
            geos-dev \
            proj4-dev \
            gdal-dev \
            protobuf-c-dev && \
    \
    wget https://download.osgeo.org/postgis/source/postgis-"${POSTGIS_VERSION}".tar.gz \
         -O /tmp/postgis.tar.gz && \
    \
    cd /tmp/ && \
        tar zxf ./postgis.tar.gz && \
        cd ./postgis-"${POSTGIS_VERSION}" && \
            ./configure --with-raster && \
            make && \
            make install && \
    \
    apk del .build-deps \
            .build-deps-testing && \
    \
    apk	--no-cache \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        --virtual .running-deps-testing \
        add geos \
            proj4 \
            gdal \
            protobuf-c \
            json-c \
            gmp \
            mpfr3 \
            boost \
            boost-serialization \
            pcre && \
    \
    ln -s \
        /usr/local/lib64/libSFCGAL.so."${SFCGAL_VERSION}" \
        /usr/local/lib/libSFCGAL.so.1 && \
    \
    rm -rf \
        /var/cache/apk/* \
        /tmp/cgal.tar.gz \
        /tmp/cgal-releases-CGAL-"${CGAL_VERSION}" \
        /tmp/sfcgal.tar.gz \
        /tmp/SFCGAL-"${SFCGAL_VERSION}" \
        /tmp/postgis.tar.gz \
        /tmp/postgis-"${POSTGIS_VERSION}"


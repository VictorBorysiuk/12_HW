ARG NGINX_VERSION=1.21.6

FROM nginx:latest

ARG NGINX_VERSION=1.19.2
ARG GEOIP2_VERSION=3.3

RUN mkdir -p /var/lib/GeoIP/

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        libpcre++-dev \
        zlib1g-dev \
        libgeoip-dev \
        libmaxminddb-dev \
        wget \
        git

RUN cd /opt \
    && git clone --depth 1 -b $GEOIP2_VERSION --single-branch https://github.com/leev/ngx_http_geoip2_module.git \
    && wget -O - http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar zxfv - \
    && mv /opt/nginx-$NGINX_VERSION /opt/nginx \
    && cd /opt/nginx \
    && ./configure --with-compat --add-dynamic-module=/opt/ngx_http_geoip2_module \
    && make modules 

FROM nginx:$NGINX_VERSION

COPY --from=0 /opt/nginx/objs/ngx_http_geoip2_module.so /usr/lib/nginx/modules

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests libmaxminddb0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && chmod -R 644 /usr/lib/nginx/modules/ngx_http_geoip2_module.so 
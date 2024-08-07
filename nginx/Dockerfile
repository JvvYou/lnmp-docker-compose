FROM centos:7
MAINTAINER  JvvYou

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN rm -rf /etc/yum.repos.d/* && echo > /etc/resolv.conf && echo "nameserver 114.114.114.114" > /etc/resolv.conf && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && yum makecache && yum install -y vim net-tools 

RUN groupadd -g 1000 www && useradd -u 1000 -s /sbin/nologin -M www -g www

RUN yum install -y perl-devel perl-ExtUtils-Embed GeoIP GeoIP-devel GeoIP-data gperftools gcc gcc-c++ make openssl openssl-devel libxml2 libxml2-devel libxslt-devel gd-devel pcre pcre-devel

RUN mkdir -p /opt/soft && mkdir -p /var/log/nginx/ && chown -R www.www /var/log/nginx && mkdir -p /opt/nginx/conf/conf.d && mkdir /alidata && chown -R www.www /alidata && mkdir -p /alidata/log/nginx && mkdir -p /alidata/log/php && chown -R www.www /alidata


ADD nginx-1.16.1.tar.gz /opt/soft/


RUN cd /opt/soft/nginx-1.16.1 && ./configure --prefix=/opt/nginx --pid-path=/opt/nginx/nginx.pid --user=www --group=www --with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module  --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic  --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module  --with-http_gunzip_module  --with-http_gzip_static_module   --with-http_auth_request_module   --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module  --with-http_slice_module   --with-http_stub_status_module --with-http_perl_module  --with-stream=dynamic   --with-stream_ssl_module  --with-stream_realip_module   --with-stream_geoip_module --with-stream_geoip_module=dynamic  --with-stream_ssl_preread_module  --with-google_perftools_module --with-compat  --with-pcre  --with-debug && make && make install

RUN rm -rf /opt/nginx/conf/nginx.conf && rm -rf /opt/nginx/conf/fastcgi_params

COPY nginx.conf /opt/nginx/conf/ 
COPY nginx_conf.d/* /opt/nginx/conf/conf.d/
COPY fastcgi_params /opt/nginx/conf/

RUN rm -rf /etc/rc.d/rc.local

COPY rc.local /etc/rc.d/rc.local

ADD format-importer-1.13.9.tar.gz /opt/soft/
RUN yum install -y python3 


EXPOSE 80
CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]



























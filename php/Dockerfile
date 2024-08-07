FROM centos:7
MAINTAINER JvvYou

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN rm -rf /etc/yum.repos.d/* && echo > /etc/resolv.conf && echo "nameserver 114.114.114.114" > /etc/resolv.conf && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && yum makecache && yum install -y vim net-tools

RUN groupadd -g 1000 www && useradd -u 1000 -s /sbin/nologin -M www -g www

RUN yum install -y python-devel bzip2 bzip2-devel gcc-c++ systemtap-sdt-devel bzip2-devel libwebp libwebp-devel libicu-devel libxslt libxslt-devel libXpm-devel curl-devel libjpeg-devel libpng-devel freetype-devel readline-devel make perl pcre pcre-devel openssl openssl-devel autoconf epel-release libmcrypt libmcrypt-devel mcrypt mhash libmcrypt-devel libmcrypt graphviz

RUN mkdir -p /opt/soft

ADD libzip-1.2.0.tar.gz /opt/soft/
ADD php-7.3.16.tar.gz /opt/soft/

RUN cd /opt/soft/libzip-1.2.0 && ./configure && make && make install && cp /usr/local/lib/libzip/include/zipconf.h /usr/local/include/zipconf.h

RUN cd /opt/soft/php-7.3.16  && ./configure --prefix=/opt/php --enable-fpm --with-fpm-user=www --with-fpm-group=www --enable-phpdbg --enable-phpdbg-webhelper --enable-phpdbg-debug --enable-phpdbg-readline --enable-debug --enable-dtrace --with-libxml-dir --with-openssl --with-pcre-regex --with-pcre-jit --with-zlib --with-zlib-dir --enable-bcmath --with-bz2 --enable-calendar --with-curl --with-pcre-dir --with-openssl-dir --with-gd --with-webp-dir --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-gd-jis-conv --with-gettext --with-mysqli --enable-intl --enable-mbstring --with-pdo-mysql --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --with-xmlrpc --with-iconv-dir --with-xsl --enable-zip --with-libzip --enable-mysqlnd --with-xpm-dir 

RUN sed -i 's/PHPDBG_EXTRA_LIBS =/PHPDBG_EXTRA_LIBS = -lreadline/g' /opt/soft/php-7.3.16/Makefile && cd /opt/soft/php-7.3.16 && make && make install

ADD redis-4.0.0.tgz /opt/soft/
ADD memcache-4.0.5.2.tgz /opt/soft/
ADD mongodb-1.7.4.tgz /opt/soft/
ADD yaf-3.1.3.tgz /opt/soft/
ADD ImageMagick.tar.gz /opt/soft/
ADD imagick-3.4.4.tgz /opt/soft/
ADD ghostscript-9.25.tar.gz /opt/soft/
ADD mcrypt-1.0.3.tgz /opt/soft/
ADD protobuf-3.21.6.tgz /opt/soft/
ADD xhprof-master.tar.gz /opt/soft/

RUN cd /opt/soft/redis-4.0.0 && /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install

RUN cd /opt/soft/memcache-4.0.5.2 && /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install

RUN cd /opt/soft/mongodb-1.7.4 && /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install

RUN cd /opt/soft/yaf-3.1.3 &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install

RUN cd /opt/soft/ImageMagick-7.0.8-62 && ./configure && make && make install

RUN cd /opt/soft/imagick-3.4.4 &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install

RUN cd /opt/soft/protobuf-3.21.6 &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install

RUN cd /opt/soft/xhprof-master/extension &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install
RUN mkdir /tmp/xhprof && chmod 777 /tmp/xhprof

RUN cd /opt/soft/ghostscript-9.25 && ./configure && make && make install && cp /opt/soft/ghostscript-9.25/bin/gs /usr/bin/

RUN yum install epel-release -y && yum install -y libmcrypt libmcrypt-devel && cd /opt/soft/mcrypt-1.0.3 &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install

COPY php.ini /opt/php/lib/php.ini
COPY php-fpm.conf /opt/php/etc/php-fpm.conf
COPY www.conf /opt/php/etc/php-fpm.d/www.conf

RUN rm -rf /etc/rc.d/rc.local

COPY rc.local /etc/rc.d/rc.local
COPY php-fpm.service /usr/lib/systemd/system/

EXPOSE 9000
CMD ["/opt/php/sbin/php-fpm"]

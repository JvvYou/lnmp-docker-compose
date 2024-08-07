FROM ubuntu:18.04

RUN apt-get update && apt-get install cron -y && apt-get install vim -y && apt-get install python -y && apt-get install python-pip python-dev build-essential -y 
RUN mkdir /opt/soft

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

#sql报错
COPY check_sql_error.sh /opt/soft/
RUN echo "* * * * * root /opt/soft/check_sql_error.sh" >> /etc/crontab
RUN pip install requests -i https://pypi.tuna.tsinghua.edu.cn/simple
COPY dingdingsql /opt/soft/
RUN chmod u+x /opt/soft/dingdingsql /opt/soft/check_sql_error.sh
#RUN apt-get install -y inetutils-ping

#php报错
RUN echo "0 0 * * * root cat /dev/null > /alidata/www/logs/php_errors.log" >> /etc/crontab
COPY check_php_error_new.sh /opt/soft/
COPY dingdingphp.py /opt/soft/
RUN chmod u+x /opt/soft/check_php_error_new.sh /opt/soft/dingdingphp.py 
RUN echo "* * * * * root /opt/soft/check_php_error_new.sh" >> /etc/crontab

CMD ["/usr/sbin/cron","-f","-L /dev/stdout"]

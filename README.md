# 日常使用的php docker环境，很稳定

## 镜像的构建
```
cd nginx/
docker build -t nginx-dd:v1 .

cd php/
docker build -t php-dd:v1 .

cd cronjob/
docker build -t cronjob:v1 .
```

## 环境启动
```
docker-compose up -d
```

## cronjob
这个是扩展了一个php和sql报错的功能的定时程序，通过钉钉告警，需要配置手机号。

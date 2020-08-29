[@Title]:<>(alpine镜像修改时区为东八区_配置阿里云的源)
[@Date]:<>(2020-08-29 12:07:00)
[@Tags]:<>(Docker,Dockerfile)



alpine镜像修改时区为东八区，配置阿里云的源。

```dockerfile
RUN echo "http://mirrors.aliyun.com/alpine/v3.11/main" > /etc/apk/repositories
RUN echo "http://mirrors.aliyun.com/alpine/v3.11/community" >> /etc/apk/repositories
RUN apk --update add --no-cache

# 修改时区为东八区
# 添加CA根证书
RUN apk --no-cache add tzdata && \
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
echo "Asia/Shanghai" > /etc/timezone && \
apk --no-cache add ca-certificates && \
rm -rf /var/cache/apk/* /tmp/*
```


[@Title]:<>(SpringBoot 2.3 打包分层Docker镜像)
[@Date]:<>(2020-06-04 23:03:00)
[@Tags]:<>(Java,SpringBoot,Docker)



pom.xml

```xml
<plugin>
<groupId>org.springframework.boot</groupId>
<artifactId>spring-boot-maven-plugin</artifactId>
<configuration>
<layers>
<enabled>true</enabled>
</layers>
</configuration>
</plugin>
```

Dockerfile:

```dockerfile
FROM openjdk:8-jdk-alpine as builder
WORKDIR application
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract
FROM openjdk:8-jdk-alpine

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

WORKDIR application
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
```


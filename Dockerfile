#=================================================
# 1. Get cache image
#=================================================
FROM registry.cn-shanghai.aliyuncs.com/1ris/meta-core:cache AS cache

#=================================================
# 2. alpha test
#=================================================

FROM openjdk:17-alpine AS alpha
# System prepare
ENV TZ=Asia/Shanghai JAVA_MEMORY=4G
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update &&\
    apk add --no-cache tzdata

RUN mkdir /opt/paper
WORKDIR /opt/paper

COPY --from=cache /opt/paper .

# Config
RUN sed -i "s/eula=false/eula=true/g" eula.txt
COPY ./config/server.properties\ 
     ./config/bukkit.yml\ 
     ./config/spigot.yml\ 
     ./config/paper.yml\ 
     ./

# Avatar
COPY ./design/server-icon.png .

ENTRYPOINT ["sh", "/opt/paper/run.sh"]

#=================================================
# 3. debug test
#=================================================

FROM openjdk:17-alpine AS debug
# System prepare
ENV TZ=Asia/Shanghai JAVA_MEMORY=1G
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update &&\
    apk add --no-cache tzdata

RUN mkdir /opt/paper
WORKDIR /opt/paper

COPY --from=fetch /opt/fetch-paper-api/target.jar ./paper.jar
COPY ./oar-core/run.sh /opt/paper/run.sh
COPY --from=cache /opt/paper/cache ./cache

# First run
COPY ./oar-core/run.sh .
RUN sh run.sh

# Config
RUN sed -i "s/eula=false/eula=true/g" eula.txt
COPY ./config/server.properties\ 
     ./config/bukkit.yml\ 
     ./config/spigot.yml\ 
     ./config/paper.yml\ 
     ./

# Avatar
COPY ./design/server-icon.png .

ENTRYPOINT ["sh", "/opt/paper/run.sh"]

#=================================================
# 1. fetch paper jar file
#=================================================

FROM python:3 AS fetch
ARG PROJECT='paper'
ARG VERSION='1.18.1'
RUN mkdir /opt/fetch-paper-api
COPY ./oar-core/fetch-paper-api/main.py ./oar-core/fetch-paper-api/requirements.txt  /opt/fetch-paper-api/
WORKDIR /opt/fetch-paper-api
RUN pip install --no-cache-dir -r requirements.txt
RUN python main.py $PROJECT $VERSION

#=================================================
# 2. First run and download cache folder
#=================================================

FROM openjdk:17-alpine AS cache

# System prepare
ENV TZ=Asia/Shanghai JAVA_MEMORY=256M
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update &&\
    apk add --no-cache tzdata

RUN mkdir /opt/paper
WORKDIR /opt/paper

COPY --from=fetch /opt/fetch-paper-api/target.jar ./paper.jar
COPY ./oar-core/run.sh /opt/paper/run.sh

# First run to cache
COPY ./oar-core/run.sh .
RUN sh run.sh

#=================================================
# 3. alpha test
#=================================================

FROM openjdk:17-alpine AS alpha
# System prepare
ENV TZ=Asia/Shanghai JAVA_MEMORY=4G
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

#=================================================
# 4. debug test
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
COPY ./oar-core/design/server-icon.png .

ENTRYPOINT ["sh", "/opt/paper/run.sh"]

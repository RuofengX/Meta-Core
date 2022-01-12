#=================================================
# 1. Get cache image
#=================================================
FROM registry.cn-shanghai.aliyuncs.com/1ris/meta-core:cache AS game-core

#=================================================
# 2. production
#=================================================

FROM amazoncorretto:17 AS production
# System prepare
ENV TZ=Asia/Shanghai JAVA_MEMORY=4G

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

FROM amazoncorretto:17 AS debug
# System prepare
ENV TZ=Asia/Shanghai JAVA_MEMORY=1G

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


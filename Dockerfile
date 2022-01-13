#=================================================
# 1. Get cache image
#=================================================
FROM registry.cn-shanghai.aliyuncs.com/1ris/game-core:latest AS game-core
FROM registry.cn-shanghai.aliyuncs.com/1ris/game-core:deb AS test-needed
#=================================================
# 2. Production
#=================================================

FROM amazoncorretto:17 AS production

# System Environment
ENV TZ=Asia/Shanghai JAVA_MEMORY=4G LANG=en_US.utf8
RUN mkdir /opt/paper
WORKDIR /opt/paper

# Copy files
COPY --from=game-core /opt/paper .

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
# 3. Test game-core
#=================================================

FROM amazoncorretto:17 AS test

# System Environment
ENV TZ=Asia/Shanghai JAVA_MEMORY=512M LANG=en_US.utf8
RUN mkdir /opt/paper
WORKDIR /opt/paper

# Copy files
COPY --from=game-core /opt/paper .

# Config
RUN sed -i "s/eula=false/eula=true/g" eula.txt
COPY ./config/server.properties\ 
     ./config/bukkit.yml\ 
     ./config/spigot.yml\ 
     ./config/paper.yml\ 
     ./

# Avatar
COPY ./design/server-icon.png .
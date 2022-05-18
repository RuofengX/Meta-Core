#!/bin/bash
#使用这个脚本将从docker启动服务器
cd minecraft-banlist
./minecraft-banlist/push.sh
cd ..
git submodule update --init --recursive  # 更新子模块
sudo docker-compose up --build -d --remove-orphans

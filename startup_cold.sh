#!/bin/bash
git submodule update --init --recursive  # 更新子模块
sudo docker rmi registry.cn-shanghai.aliyuncs.com/1ris/game-core:latest  # 删除旧版本镜像
sudo docker-compose up --build -d --remove-orphans

#!/bin/bash
#使用这个脚本将从docker启动服务器
git submodule update --init --recursive  # 更新子模块
sudo docker-compose up --build -d --remove-orphans

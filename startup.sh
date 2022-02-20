#!/bin/bash
git submodule update --init --recursive  # 更新子模块
sudo docker-compose up --build -d --remove-orphans

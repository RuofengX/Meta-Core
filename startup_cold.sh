#!/bin/bash
sudo docker rmi registry.cn-shanghai.aliyuncs.com/1ris/game-core:latest
sudo docker-compose up --build -d --remove-orphans

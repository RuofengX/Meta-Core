# Meta-Core  

Meta世界的核心  
Docker多阶段构建 + docker-compose运行。

## 使用说明  
1. 首先配置密钥。  
2. 运行`https://github.com/RuofengX/Meta-Core`克隆仓库到本地。  
3. 运行`./startup_cold.sh`冷启动 | 或者运行`./startup.sh`不更新paper内核启动  
4. 使用`./attach.sh`连接到游戏Console，务必保存存档之后再销毁容器。  
5. 修改docker-compose.yml文件，主要是在volume分类中挂载正确的存档文件夹  
5. ban玩家的同时也要ban-ip，之后运行  
```bash
cd minecraft-banlist
./minecraft-banlist/push.sh
cd ..
```
来同步ban人列表（需要gitee访问权限）  

## TODOs
- [x]server.properties中的难度选项无法正确初始化  
  A: 存档文件记录难度、gamerule等,保存在nfs中

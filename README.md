# Meta-Core  

Meta世界的核心  
Docker多阶段构建 + docker-compose运行。

## 密钥配置  
1. 使用命令`git clone git@codeup.aliyun.com:61d596eb0a8596bb8ae3ec6a/meta-core.git`克隆项目  
2. 如果提示鉴权失败，则需要执行以下步骤——登录core实例，配置密钥对  

```
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -q -t ed25519 -C "weiruofeng@ruofengx.cn" -f ~/.ssh/id_ed25519 -N ''
echo $(cat ~/.ssh/id_ed25519.pub)
```  

3. 让管理员将公钥添加到仓库设置中  

## 使用说明  
1. 首先配置密钥。  
2. 运行`git clone --recursive https://gitee.com/ruofengx/meta-core.git`克隆仓库到本地。  
3. 运行`./startup_cold.sh`冷启动
| 或者运行`./startup.sh`不更新paper内核启动  
4. 使用`./attach.sh`连接到游戏Console，务必保存存档之后再销毁容器。  
5. ban玩家的同时也要ban-ip，之后运行  
```bash
cd minecraft-banlist
./minecraft-banlist/push.sh
cd ..
```
同步ban人列表（需要gitee访问权限）  

## TODOs
- [x]server.properties中的难度选项无法正确初始化  
  A: 存档文件记录难度、gamerule等,保存在nfs中

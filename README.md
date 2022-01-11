# Meta-Core  
Meta世界的核心
## 子模块  
由于使用了git子模块，需要在克隆时加上递归选项：  


## 运行说明
1. 使用命令`git clone --recursive https://gitee.com/ruofengx/meta-core.git `克隆项目  
2. 登录core实例，配置密钥对:
```
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -q -t ed25519 -C "weiruofeng@ruofengx.cn" -f ~/.ssh/id_ed25519 -N ''
echo $(cat ~/.ssh/id_ed25519.pub)
```  
3. 将结果复制到ruofengx的[管理界面](https://gitee.com/profile/sshkeys)，详细步骤请查看[帮助文档](https://gitee.com/help/articles/4181)
4. 运行`git clone --recursive https://gitee.com/ruofengx/meta-core.git`克隆仓库到本地  
5. 运行 `docker-compose up --build -d --remove-orphans`启动  

## 开发说明  
1. 私有仓库SSH密钥配置[帮助文档](https://gitee.com/help/articles/4181)  
2. 使用命令`git clone --recursive https://gitee.com/ruofengx/meta-core.git `克隆项目  
3. 使用命令`git submodule update --recursive`更新子模块  
4. `docker-compose -f debug.yml up --build -d --remove-orphans`启动debug实例  
4. 使用命令`docker build --target debug -o docker-fs/debug`保存镜像文件系统到本地查看  

# 技术约定  
## 端口  
- 25565: OAR Oasis服的velocity加密端口，内网；  
- 25575: OAR Meta服的velocity加密端口，内网；  
- 60000: S-2网络四层转发节点目标端口，带pp数据包；  
## TODOs  
[ ] 1. Prevent papermc core save log file in logs folder.  
[ ] 2. Convert OAR Oasis to docker container.  
[x] 3. Multi stage build to solve download vallina slow.  
# Meta-Core  
Meta世界的核心  
改变往常笨重、有限的服务器部署方式，采用Docker应用镜像进行服务器端的部署和运行。将传统软件拆分为：无状态镜像 + 无状态服务 + 有状态程序三个部分，提高了服务器部署的灵活性。

## 基本配置  
1. 使用命令`git clone https://gitee.com/ruofengx/meta-core.git `克隆项目  
2. 登录core实例，配置密钥对
```
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -q -t ed25519 -C "weiruofeng@ruofengx.cn" -f ~/.ssh/id_ed25519 -N ''
echo $(cat ~/.ssh/id_ed25519.pub)
```  
3. 让管理员将公钥添加到仓库设置中  
> #### 有用的提示  
> 1. 运行`git clone --recursive https://gitee.com/ruofengx/meta-core.git`克隆仓库到本地  
> 2. 运行`docker-compose up --build -d --remove-orphans`启动  
> 3. 销毁容器前务必保存存档！！！！！！

## 部署流程  
项目为加快构建时间采用了多阶段部署，相关配置文件说明如下：  
- ### 无状态镜像  
  Dockerfile-core将从papermc.io/api下载并初步构建（无配置文件）一个代号`game-core`的半成品镜像。对应上游提供的特定版本的服务端软件。项目使用CI将镜像传输至国内仓库，地址为`registry.cn-shanghai.aliyuncs.com/1ris/game-core:latest`。  
  > #### 测试  
  > mater分支进行tag之前需要手动运行test-game-core.sh脚本，无异常后方可添加tag，push之后CI会自动更新latest镜像。
- ### 无状态服务  
  Dockerfile将会使用最新的`game-core`作为加速镜像，并加载config文件夹中的配置文件，内存等java启动参数在这里配置。  
- ### 有状态程序  
  docker-compose.yml配置了协同运作的硬件周边，nfs挂载在这里配置。同时，使用compose还可以方便的管理应用。运行startup.sh即可部署。  
## 开发说明  
> #### 一些有用的提示  
> 1. `git clone --recursive https://gitee.com/ruofengx/meta-core.git `克隆项目  
> 2. `git submodule update --recursive`更新子模块  
> 3. `docker-compose -f debug.yml up --build -d --remove-orphans`启动debug实例  
> 4. `docker build --target debug -o docker-fs/debug`保存镜像文件系统到本地查看  

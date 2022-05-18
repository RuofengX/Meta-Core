import asyncio
import warnings
import uvloop
from Aisle import LogMixin

class MetaCore(LogMixin):
    """无限热爱
    
    MetaCore守护进程
    
    功能:
    - 启动默认容器
    - 启动TimeMachine容器
        - 下载并解压存档
        - 修改docker-compose.genetic.yml的配置
        
    - RESTful API
    - 全异步
    - 异常处理
    
    """
    raise NotImplementedError
        

class ContainerBase():
    raise NotImplementedError

class TimeMachineContainer(ContainerBase):
    """获取指定时间的存档、启动容器进程
    """
    def __init__(self):
        raise NotImplementedError
        
        pass
    
    def get_time_slice(self, time_slice):
        
        cfs = CloudFileSystem("./TENCENT_KEY")



class CloudFileSystem():
    def __init__(self, config_path):
        
        try:
            with open(path, mode='rt') as f:
                self.api_id, self.api_key = f.readlines()
        except IOError as err:
            warnings.warn('IOError, check if TENCENT_KEY file is exsit')
            raise err
        
    def restore_from_snapshot(self, name):
        """从快照新建文件系统
        
            name: 快照名字
        
        """
        raise NotImplementedError
        


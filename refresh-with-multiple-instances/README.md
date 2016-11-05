### 本地运行 

1.启动相关组件

```
./build.sh
./start_config_server.sh
./start_service.sh
```

2.修改config-repo中的配置文件event.yml

3.执行如下命令

```
curl -X POST http://localhost:9000/bus/refresh  
或者
curl -X POST http://localhost:8020/bus/refresh?destination=event:**
```

### 使用Docker运行

1.启动相关组件

```
docker-compose up --build
```

2.修改config-repo中的配置文件event.yml

3.执行如下命令

```
curl -X POST http://localhost:9000/bus/refresh
或者
curl -X POST http://localhost:8020/bus/refresh?destination=event:**
```

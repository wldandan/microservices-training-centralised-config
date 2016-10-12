### 本地运行
```
./build.sh
./start_config_server.sh
./start_service.sh
```

修改config-repo中的配置文件event-service-docker.properties

执行如下命令
```
curl -X POST http://localhost:8080/bus/refresh
curl -X POST http://localhost:8888/bus/refresh?destination=event-service:**
```

### 使用Docker运行
执行
```
docker-compose up --build
```

修改config-repo中的配置文件event-service-docker.properties(github)

执行如下命令
```
curl -X POST http://localhost:8080/bus/refresh
curl -X POST http://localhost:8888/bus/refresh?destination=event-service:**
```

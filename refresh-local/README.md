### 本地运行
```
./build.sh
./start_config_server.sh
./start_service.sh

修改config-repo中的配置文件event-service.properties

执行如下命令
curl -X POST http://localhost:8080/refresh
```

### 使用Docker运行
配置信息需要访问Github
执行
```
docker-compose up --build
```


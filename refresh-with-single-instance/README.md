### 本地运行
```
./script/build.sh 
./script/start_config_server.sh
./script/start_service.sh

### 使用Docker运行
执行
```
docker-compose up --build
```

### 执行如下命令动态
curl -X POST http://localhost:8080/refresh
```

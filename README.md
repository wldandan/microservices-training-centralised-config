## 基本介绍

本节课包括两部分内容：

### 1. refresh-local 
 
本小节演示如何使用本地配置文件控制[特性开关](http://martinfowler.com/articles/feature-toggles.html)feature.x.enable，并动态变更Event-service的处理逻辑

| 组件或者服务    | 端口号    | 访问地址| 
|-------------|------------|-------|
|配置中心 Spring Cloud Config Server|8020|http://localhost:8020/event/[default|dev|production|docker]|
|Event Service|9000|http://localhost:9000或者http://localhost:9000/events|

#### 准备条件

* 本地文件系统存储配置信息
* Config server
* Event service的1个实例


#### 执行过程(本地)

* a) 启动Config Server与Eventservice实例

```
SERVER_PORT=8020 java -jar build/libs/config-server.0.0.1.jar &&
SERVER_PORT=9000 java -jar buid/libs/event-service-0.0.1.jar &&
```

验证
```
[SERVICE]/[PROFILE]/[BRANCH]
http://localhost:8020/event/development/
http://localhost:8020/event/development/test
```

* b) 修改配置文件
* c) 查看Config server的变化
* d) 执行动态刷新(curl -X POST http://[service-host]:[service-port]/refresh)

```
curl -X POST localhost:9000/refresh
```	

* e) 访问localhost:9000，查看event-service
* f) 使用localhost:9000/env查看相关配置

#### 执行过程(Docker)
```
docker-compose up
```
则如上b)中修改配置文件，需要提交到git remote repo中

---

### 2. refresh-with-ma

本小节演示如何使用RabbitMQ，动态更新event-service的一组实例

| 组件或者服务    | 端口号    | 访问地址| 
|-------------|------------|-------|
|配置中心 Spring Cloud Config Server|8020|http://localhost:8020/event/docker|
|Event Service-1|9000|http://localhost:9000或者http://localhost:9000/events|
|Event Service-2|9001|http://localhost:9001或者http://localhost:9001/events|

#### 准备条件

* 使用github(或者coding.net)存储配置信息
* 使用RabbitMQ同步消息
* Config-server
* Event-service的两个实例

#### 执行过程

* a) 启动Config server与Event service的两个实例
 
```
SERVER_PORT=8020 java -jar build/libs/config-server.0.0.1.jar &&
SERVER_PORT=9000 java -jar buid/libs/event-service-0.0.1.jar &&
SERVER_PORT=9001 java -jar buid/libs/event-service-0.0.1.jar
```
* b) 修改配置文件，并提交github(或者coding.net)
* c) 查看Config server的变化
* d) 向其中一个实例发送配置信息刷新请求

```
//curl -X POST http://[service-host]:[service-port]/bus/refresh
curl -X POST localhost:9000/bus/refresh
```	

* e) 访问Eventservice的另外一个实例，localhost:9001/

#### 或者使用Docker运行

```
docker-compose up --build
```
## 创建Config-server和Config-client 

** 第一部分 - 创建Conifg-server **

1. 创建Spring-boot应用
   * 使用start.spring.io(http://start.spring.io/) 或者IDE创建应用
   * 命名为cofig-server 
   * 设置端口为8020

2. 检查依赖
    * spring-cloud-config-server
    * spring-cloud-starter-bus-amqp

3. 使用@EnableConfigServer定义SpringBoot的Application

4. 创建配置文件相关目录config-repo
    * 本地文件

5. 在config-repo中定义配置文件，如"{spring-application}-{profile}.yml” (event-service-*.properties).
    * 定义feature.x.enable

6. 运行config-server，访问http://localhost:8021/event-service/default/
                         http://localhost:8021/event-service/development
    
----------------------------------------------------------------------------

** 第二部分 - 创建Conifg-client **

1. 创建Spring-boot应用
   * 使用start.spring.io(http://start.spring.io/) 或者IDE创建应用
   * 命名为{name}-service(event-service)
   * 设置端口为9000

2. 检查依赖
   * spring-cloud-starter-config
   * spring-cloud-starter-bus-amqp

3. 在bootstrap.{yml|properties}中设置服务的相关参数
    spring.application.name=event-service
    server.port=9000
    spring.cloud.config.uri=http://localhost:8020

4. 在EventController中使用配置信息
    @Value("${feature.x.enable}")
    String featureXEnable;

5. 运行服务，访问 localhost:9000/

---------------------------------------------------------------------------

** 第三部分 - 使用Spring Cloud Bus实现多实例配置刷新

  1. 停掉所有的服务

  2. 安装rabbitmq(rabbitmq_server-3.6.5)
     启动rabbitmq server
    ```sbin/rabbitmq-server```

  3. 启动config-server
    ```可以使用本地的config-repo```

  4. 启动多个event-service的实例
    SERVER_PORT=9000 ./gradlew bootRun
    SERVER_PORT=9001 ./gradlew bootRun

  5. 改变config-repo中的参数，譬如 

  4. 执行```curl -X POST http://localhost:9000/bus/refresh```，可以看到两个运行event-service结点的刷新，返回结果类似
  ["feature.x.enable"]

  或者执行```curl -X POST http://localhost:8020/bus/refresh?destination=event-service:**```

  5. 然后刷新http://localhost:9000，http://localhost:9001，可以看到变化

---------------------------------------------------------------------------

** 第四部分 - 使用Docker运行Spring Cloud Bus与多实例配置

  如果使用Docker，则执行
  ```docker-compose up --build```

  包括了Rabbitmq、Config-server和Event-service

  目前docker环境下，只有向config-server发请求，同步刷新工作正常
    执行```curl -X POST http://localhost:8020/bus/refresh?destination=event-service:**```

  执行如下命令，向其中某结点发送请求，另外的结点并没有收到信息
    ```curl -X POST http://localhost:9000/bus/refresh```  
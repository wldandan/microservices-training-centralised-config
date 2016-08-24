## 创建Config-server和Config-client 

** 第一部分 - 创建Conifg-server **

1. 创建Spring-boot应用
   * 使用start.spring.io(http://start.spring.io/) 或者IDE创建应用
   * 命名为cofig-server 
   * 设置端口为8888

2. 检查依赖
    * spring-cloud-config-server

3. 使用@EnableConfigServer定义SpringBoot的主类


4. 创建配置文件相关目录config-repo
    * 本地文件
    * 或者github


5. 在config-repo中定义配置文件，如"{spring-application}-{profile}.yml” (或者properties文件).
    * 本例中使用Git和本地文件，并定义event-service.properties
    * 定义database.username=admin
    * 定义分支testdatabase.username=[test]admin    


6. 运行config-server，访问http://localhost:8888/event-service/default/
   或者尝试访问如下不同的URL
    /{application}/{profile}
    http://localhost:8888/event-service/development
    //event-service-development.properties
    http://localhost:8888/event-service/production
    //event-service-production.properties

    /{application}/{profile}[/{label}]
    http://localhost:8888/event-service/development/master
    //event-service-development.properties in master branch

    http://localhost:8888/event-service/production/test
    //event-service-production.properties in test branch

------------------------------------------------------------------------------------------

** 第二部分 - 创建Conifg-client **

1. 创建Spring-boot应用
   * 使用start.spring.io(http://start.spring.io/) 或者IDE创建应用
   * 命名为cofig-client或{name}-service
   * 设置端口为9999

2. 检查依赖
   * spring-cloud-starter-config

3. 在bootstrap.{yml|properties}中设置服务的相关参数
    spring.application.name=event-service
    server.port=9999
    spring.cloud.config.uri=http://localhost:8888

4. 在EventController中使用配置信息
    @Value("${database.url}")
    String dbUrl;

5. 运行服务，访问 localhost:9999/

------------------------------------------------------------------------------------------

**** 提示 - 通过spring profile访问不同配置文件****

1. 创建配置文件，命名为"event-service-production.properties”, 并修改相应的参数：
   譬如database.url，database.username，database.password

2. 修改bootstrap文件，包含spring.profiles.active: production.
   或者也可以直接使用SPRIG_PROFILES_ACTIVE=production gradle bootRun 来运行

------------------------------------------------------------------------------------------

** 第三部分 - 使用RefreshScope自动刷新单实例配置

  1. 在Event-service中增加依赖，其提供/refresh接口
  * spring-boot-starter-actuator

  2. 在EventController中增加，并启动event-service
    @RefreshScope

  3. 改变config-repo中的参数，譬如 
   "database.username=admin-new-change"

  4. 新开窗口，发送'curl -X POST http://localhost:9999/refresh'，返回结果类似
  ["database.username"]

  5. 然后刷新http://localhost:9999
   
------------------------------------------------------------------------------------------

** 第三部分 - 使用Spring Cloud Bus 与 RefreshScope自动刷新多实例配置

  1. 在Event-service中增加依赖
    spring-cloud-starter-bus-amqp
  
  2. 启动rabbitmq server

  3. 启动config-server

  4. 启动多个event-service的实例
    SERVER_PORT=9999 gradle bootRun
    SERVER_PORT=9998 gradle bootRun

  5. 改变config-repo中的参数，譬如 
   "database.username=admin-new-change"

  4. 新开窗口，发送'curl -X POST http://localhost:9999/bus/refresh'，可以看到两个运行event-service的实例，返回结果类似
  ["database.username"]

  5. 然后刷新http://localhost:9999，http://localhost:9998

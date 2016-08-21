## Create a Spring Cloud Config Server and Client

** Part 0 - Setup RabbitMQ

1.  Download Rabbit MQ from [https://www.rabbitmq.com/download.html](https://www.rabbitmq.com/download.html).  Use appropriate distribution for your platform.  

2.  Launch Rabbit MQ and leave it running.(Current version is 3.6.5)

/sbin/rabbitmq-server

** Part 1 - Create Config Server 

1. Start Config Server

2. Config the spring-cloud-cofig-uri by remote git url
spring:
  cloud:
    config:
      server:
        git:
          uri: https://github.com/microservice-in-action/config-repo

or local git folder
spring:
  cloud:
    config:
      server:
        git:
          uri: file://${user.home}/Work/training/further-spike/training/centralized-config/config-repo


3. Run Config Server

** Part 2 - Run config client

1. Run 2 instance of event-service
cd event-service
SERVER_PORT=9998 gradle bootRun

cd event-service
SERVER_PORT=9999 gradle bootRun

2. access http://localhost:9998 and http://localhost:9999 to see the value

3. change the configuration and push to github

4. execute the refresh to one of event-service instance
    curl -X POST http://localhost:9999/bus/refresh

5. check the other instance http://localhost:9998, and should see the change has been done in both the two instance(9998 and 9999)



  
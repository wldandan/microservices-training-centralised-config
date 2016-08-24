cd config-server
#gradle build
java -jar build/libs/config-server-0.0.1-SNAPSHOT.jar&
open 'http://localhost:8888/event-service/development/'&
open 'http://localhost:8888/event-service/development/test'
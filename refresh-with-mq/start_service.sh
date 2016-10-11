
cd config-server
SERVER_PORT=8888 java -jar build/libs/config-server-0.0.1.jar
cd -

cd event-service
#gradle build
SERVER_PORT=8080 java -jar build/libs/event-service-0.0.1.jar&
SERVER_PORT=8090 java -jar build/libs/event-service-0.0.1.jar
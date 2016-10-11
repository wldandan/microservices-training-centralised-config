FROM java:8

RUN mkdir /app
WORKDIR /app

ADD ./build/libs/config-server-0.0.1.jar /app
RUN ln -sf config-server-0.0.1.jar config-server-latest.jar
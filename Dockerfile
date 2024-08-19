FROM openjdk:17-alpine

RUN apk update && apk upgrade && \
    apk add \
    curl \
    maven

RUN mkdir /code

COPY . /code

RUN cd /code && \
    mvn package && \
    mkdir /opt/app && \
    mv /code/target/eureka-server-0.0.1-SNAPSHOT.jar /opt/app && \
    apk del maven && \
    rm -r /code

EXPOSE 30180

WORKDIR /opt/app

CMD java -Xms150m -Xmx250m -jar eureka-server-0.0.1-SNAPSHOT.jar
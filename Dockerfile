# fetch basic image
FROM maven:3.6.0-jdk-11

# application placed into /opt/app
RUN mkdir -p /opt/app
WORKDIR /opt/app

# Add the scripts directory to docker image
COPY /scripts .

# Add the jar file to the directory
ADD target/DockerApiDemo-1.0.0.jar .

# Download kafka
ADD http://apache.uib.no/kafka/2.1.1/kafka_2.12-2.1.1.tgz .

#Extract Kafka
RUN tar -xzf kafka_2.12-2.1.1.tgz

#Set Kafka environment variables
ENV KAFKA_HOME /opt/app/kafka_2.12-2.1.1
ENV PATH="${KAFKA_HOME}/bin:${PATH}"

#local application port
EXPOSE 8082

# Tell docker on how to start the spring boot application
ENTRYPOINT ["java","-jar","DockerApiDemo-1.0.0.jar"]

#start zookeeper
CMD ["start-zookeeper.sh"]

#start kafka
CMD ["start-kafka.sh"]
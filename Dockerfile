FROM amd64/openjdk:11-jre-slim

VOLUME /tmp
COPY spring-boot-docker-0.0.1-master-SNAPSHOT.jar app.jar
RUN sh -c 'touch /app.jar'

EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

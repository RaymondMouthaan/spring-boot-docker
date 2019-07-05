FROM amd64/openjdk:11-jre-slim

ARG PACKAGE_VERSION

COPY target/spring-boot-docker-${PACKAGE_VERSION}.jar app.jar
RUN sh -c 'touch /app.jar'

EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

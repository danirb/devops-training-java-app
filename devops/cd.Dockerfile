FROM openjdk:11-jre-slim
ARG VERSION=1.0.4-SNAPSHOT

COPY ./target/spring-boot-2-hello-world-${VERSION}.jar /usr/local/lib/app.jar
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]
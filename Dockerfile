FROM openjdk:17-jdk-alpine
ARG JAR_FILE=target/*.war
COPY ${JAR_FILE} app.war
ENTRYPOINT ["java","-jar","/app.war"]
EXPOSE 8080 
FROM openjdk:18
ARG JAR_FILE=target/*.war
COPY ${JAR_FILE} /app.war
#ENTRYPOINT ["java","-jar","/app.war"]
ENTRYPOINT ["/bin/sh"]
EXPOSE 8080

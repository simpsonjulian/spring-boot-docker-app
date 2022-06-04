app.war:
	./gradlew war



docker: app.war
	docker build --platform linux/amd64 --build-arg JAR_FILE=build/libs/\demo-0.0.1-SNAPSHOT.war -t springio/gs-spring-boot-docker .



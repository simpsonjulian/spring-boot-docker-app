export VERSION=1.0.0
app.war:
	 ./gradlew -Pversion=$(VERSION) build war
	ls build/libs

docker: app.war
	docker build --platform linux/amd64 --build-arg JAR_FILE=build/libs/\demo-$(VERSION).war -t demo:$(VERSION) .

deploy: docker
	envsubst < kubernetes.yml | kubectl apply -f -

clean:
	./gradlew clean

.PHONEY: app.war docker clean
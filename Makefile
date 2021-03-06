export VERSION=1.0.0
app.war:
	 ./gradlew -Pversion=$(VERSION) clean build war
	ls build/libs

docker: app.war
	docker build --platform linux/amd64 --build-arg JAR_FILE=build/libs/\demo-$(VERSION).war -t demo:$(VERSION) .

test: docker
	./packaging_test.sh $(VERSION)

clean:
	./gradlew clean

deploy:
	(cd tf && terraform apply  -auto-approve)


.PHONEY: app.war docker clean test cluster

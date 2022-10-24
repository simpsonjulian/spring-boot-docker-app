export VERSION=1.0.0
app.war:
	 ./gradlew -a -Pversion=$(VERSION) clean build war
	 cp build/libs/demo-$(VERSION).war app.war

lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

docker: app.war lint
	docker build --platform linux/amd64 --build-arg JAR_FILE=build/libs/\demo-$(VERSION).war -t demo:$(VERSION) .
	trivy image demo:${VERSION} --exit-code 1  --ignore-unfixed  --severity CRITICAL #,HIGH

test: docker
	./packaging_test.sh $(VERSION)

clean:
	./gradlew clean
	rm -f app.war

deploy:
	(cd tf && terraform apply  -auto-approve)



.PHONEY: docker clean test cluster lint

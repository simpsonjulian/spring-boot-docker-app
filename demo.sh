#!/bin/bash
date
curl localhost:8080
echo "Compiling app, making docker image"
make docker VERSION=1.1.0
echo "Flipping the deployment to use a new image"
make deploy VERSION=1.1.0
echo "Rolling out the new image"
./deploy.sh
echo "Docker image is deployed"
curl localhost:8080
date

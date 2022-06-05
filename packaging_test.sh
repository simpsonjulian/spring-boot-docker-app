#!/bin/bash

[ "$#" -ne 1 ]  && exit 1
VERSION=$1

set -euo pipefail


remove_container() {
  docker kill "${container_id}" > /dev/null
  echo "Removed container ${container_id}"
}
# remove the container whatever happens to the test
trap remove_container EXIT


container_id=$(docker run -d -p 8080:8080 --platform linux/amd64 demo:$VERSION )
echo "Spun up container with ID ${container_id}"
sleep 30
curl -s http://localhost:8080 | grep Docker
echo "^^^ some output from the container was found."



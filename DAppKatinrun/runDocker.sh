#!/bin/sh
set -x
docker rm -f katinrun
docker run --name katinrun -p 8080:80 -v $PWD/:/usr/share/nginx/html:ro -d nginx:alpine
set +x
echo "Go to http://localhost:8080"
#!/bin/sh

export BLOG_TAG="1.2"

docker pull ${DOCKER_USER}/blog:BLOG_TAG
if [ $? -eq 0 ]
then
   echo "Image already exist. Aborting build and deploy"
   echo "Please bump the version to create a new image"
   exit 1
fi

echo "Start to build new docker image"
docker build -t ${DOCKER_USER}/blog:${BLOG_TAG} --rm docker
docker push ${DOCKER_USER}/blog:${BLOG_TAG}
docker rmi $(docker images --filter=reference="${DOCKER_USER}/blog" -q)

echo "Start to deploy in k8s"
kubectl set image deployment/blog blog="$DOCKER_USER"/blog:$BLOG_TAG
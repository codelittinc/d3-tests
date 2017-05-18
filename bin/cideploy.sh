#!/usr/bin/env bash

echo "inserting the image version in docker-compose template"
bash -c 'sed -i "s/codelittinc\/codelitt-labs/codelittinc\/codelitt-labs:$VERSION/" config/docker-compose.yml.template'

echo "copying docker-compose"
scp config/docker-compose.yml.template $DEPLOY_USER@$DEPLOY_HOST:/opt/codelitt-site/config/docker-compose.yml.labs


echo "pulling latest version of the code"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker-compose -f /opt/codelitt-site/config/docker-compose.yml.labs  pull codelitt-labs"

echo "starting the new version"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker-compose -f /opt/codelitt-site/config/docker-compose.yml.labs up -d codelitt-labs"

echo "removing old and unsed images"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker images --filter 'dangling=true' --format '{{.ID}}' | xargs docker rmi"

echo "success!"

exit 0

#!/usr/bin/env bash

links_file=$1
tab_file=$2

cd qns
if [ -z "${tab_file}"];then
  echo "Running qns with file "$links_file"..."
  ./qns $links_file -e -v 0 -cfg
else
  echo "Running qns with file "$links_file" and "$tab_file"..."
  ./qns $links_file -c $tab_file -e -v 0 -cfg
fi
cd ..
echo "Launching Docker..."

docker-compose up -d sweb

docker-compose exec sweb ./launch-from-qns-inside-docker.sh
echo "Check here for diagram: http://localhost:9090/mySyntenyPortal/htdocs/syncircos.php"

docker-compose exec sweb /bin/bash

#TODO should the container be stopped?
echo "Stopping Container..."

docker-compose rm --stop -f sweb

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

docker run -t -d --name mySyntenyPortal --rm -p 9090:80 -v $PWD:/code sweb
docker exec mySyntenyPortal ./launch-from-qns-inside-docker.sh
echo "Check here for diagram: http://localhost:9090/mySyntenyPortal/htdocs/syncircos.php"
docker exec -it mySyntenyPortal /bin/bash
echo "Stopping Container..."
docker stop mySyntenyPortal

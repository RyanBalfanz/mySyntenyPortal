#!/usr/bin/env bash

links_file=$1
tab_file=$2


cd qns

mkdir output

if [[ -z "${tab_file}" ]];then
  echo "Running qns with file "${links_file}"..."
  docker-compose -f docker-compose.yml run qns ${links_file} -o ./output/ -v 0 -m --export-config
else
  echo "Running qns with file "${links_file}" and "${tab_file}"..."
  docker-compose -f docker-compose.yml run qns qns/${links_file} -c qns/${tab_file} -v 0 -m --export-config
fi

# move files to MSP input
mv output/*.{sizes,synteny} ../data/example_inputs/
mv output/qns.conf ../configurations/

cd ..
echo "Launching Docker..."

# Up won't duplicate service, so we can use start and stop for faster run time
docker-compose up -d sweb
docker-compose start sweb

docker-compose exec sweb ./launch-from-qns-inside-docker.sh
echo "Check here for diagram: http://localhost:9090/mySyntenyPortal/htdocs/syncircos.php"

# Wait for user input to stop container
read -rsn1 -p"Press any key to continue";echo
echo "Stopping Container..."

# Stop container in background, so user can access command line sooner
#
docker-compose stop -t 2 sweb > /dev/null 2>&1 &


# Stop container after 5 minutes
# Stopping the container is slow, especially if the user is going to restart it with another run right after.
#nohup bash -c "sleep 5m; docker-compose stop sweb"> /dev/null 2>&1 &


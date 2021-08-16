#!/usr/bin/env bash

# Up won't duplicate service, so we can use start and stop for faster run time
docker-compose up -d sweb
docker-compose start sweb

docker-compose exec sweb perl ./mySyntenyPortal build -conf ./configurations/qns.conf
echo "Check here for diagram: http://localhost:9090/mySyntenyPortal/htdocs/syncircos.php"

# Wait for user input to stop container
read -rsn1 -p"Press any key to terminate mySyntenyPortal";echo

# Stop container in background, so user can access command line sooner
docker-compose stop -t 2 sweb > /dev/null 2>&1 &

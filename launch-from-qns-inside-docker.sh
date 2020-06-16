#!/usr/bin/env bash

perl ./install.pl build
./launch-inside-docker.sh
perl ./mySyntenyPortal build -conf ./configurations/qns.conf

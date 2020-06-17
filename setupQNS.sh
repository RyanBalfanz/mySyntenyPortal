#!/usr/bin/env bash

echo "Cloning QNS into MSP..."
git clone https://github.com/calacademy-research/qns.git

echo "Building Docker Container for MSP..."
./build-docker.sh

echo "Setting Up Virtual Environement for QNS..."
cd qns
python3 -m venv env
source env/bin/activate
pip3 install -r requirements.txt

echo "Done!"

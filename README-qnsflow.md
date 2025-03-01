# QNS-MSP Dataflow Documentation

## Purpose  
The goal of QNS-MSP is to integrate the files generated from qns directly into MSP. With this integration a single simple script can be used to kick off the following processes,

* Run QNS with .links and .tab files
* Create .synteny and .size files
* Generate .conf files for MSP
* Setup and launch MSP
* Load diagram from .conf file using .synteny and .size files.

## Requirements
* Docker engine version 17.06.0+
* docker-compose version 1.17.1+

## Installation

## Quickstart/cliff notes
  Generate MySyntenyPortal output files from QNS per the qns project options.
  
`./qns.py -m --export-config -v 0 -o <output_dir> <links and/or karyotype files>`

This will create a .conf file, a .synteny file, and a .sizes file. The .conf file
will have pointers to the .synteny file.

Once these files are generated, launch the dockerized MySyntenyPortal with:

`./run-from-qns -i qns_output`



### General Setup

Currently this project involves a combination of two existing projects.  

1. Make sure mySyntenyPortal is installed. To install, run

		git clone https://github.com/calacademy-research/mySyntenyPortal.git

2. Clone QNS into the mySyntenyPortal directory

		git clone https://github.com/calacademy-research/qns.git ./mySyntenyPortal/qns

	The structure should be:

		mySyntenyPortal/
		├── run-from-qns.sh
		├── install.pl
		├── qns
		│   ├── qns
		│   ├── config.ini
		│   ├── ...
		├── ...


3. (Optional) Build MSP and QNS before first run. If you're not planning on running qns right away, this will save some time on the first run:

		docker-compose -f docker-compose.yml -f qns/docker-compose.yml build --parallel

**TODO: once the project is released, upload both images to docker hub so they don't have to be built**
### Non-Docker-Compose Setup

In order to run the MSP-QNS project without running QNS within a docker container, install a virtual envirionemtn within QNS.

`cd qns`  
`python3 -m venv env`  
`source env/bin/activate`  
`pip3 install -r requirements.txt`  
  

Now, ensure that the virtual environment is running before kicking off ./run-from-qns

## Usage

Make sure you are in the `mySyntenyPortal` directory

Then run the `run-from-qns` script with the following format:  

`./run-from-qns [.links filename] -c [.tab filename] -c [.tab filename] -d`  

The `-d` tag tells the program to run QNS with docker compose, if omitted, virtual environment is expected.   
`./run-from-qns` accepts the same flags as QNS, but ignores the ones that would cause it to not function properly with QNS.   

Note that this script expects the filenames of files in the /qns directory, therefore the full path is not required. Also, note that the .tab file is optional, the diagram will still generate without them.

## What's going on:

run-from-qns is running the QNS program with the arguments:

`./qns.py -m --export-config -v 0 -o <output_dir> <links and/or karyotype files>`

These arguments place a mySyntenyPortal links file and .conf files in the target output directory. This
script creates an output dir (user configurable) and then copies those files into the appropiate 
directories for MSP. It then runs kick-off-docker.sh to launch MSP.

### Example Usage
Here are some example usages:

Run QNS, using "chel_gallus.links" in the qns directory, place output in $PWD/qns_output, and run 
mySyntenyPortal:
`./run-from-qns --run-qns -i qns_output chel_gallus.links`

Do not run QNS, take exising MSP files from qns_output and run:
`./run-from-qns -i qns_output`

Run QNS and clean up everything:
`./run-from-qns --run-qns -i qns_output --clean-qns-output chel_gallus.links`
`./run-from-qns --run-qns --clean-qns-output Tse_Allig.links -c Tse-karyotype.tab -c Allig-karyotype.tab`  
`./run-from-qns --run-qns --clean-qns-output Tse_Goph.links -c Tse-karyotype.tab -c Goph-karyotype.tab`  
  
## Notes
`./run-from-qns` currently forcefully passes the flags `-o ./output/ -v 0 -m --export-config`.

`-m` and `--export-config` generate required files for mySyntenyPortal, `-v 0` just silences the output.  

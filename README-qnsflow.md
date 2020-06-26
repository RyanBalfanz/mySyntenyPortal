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

**TODO: review this, maybe it makes more sense to have path from `mySyntenyPortal/` instead of `qns/`**

### Example Usage
Here are some example usages:

`./run-from-qns Tse_Allig.links -c Tse-karyotype.tab -c Allig-karyotype.tab`  
`./run-from-qns Tse_Goph.links -c Tse-karyotype.tab -c Goph-karyotype.tab`  
  
## Notes
`./run-from-qns` currently forcefully passes the flags `-o ./output/ -v 0 -m --export-config`.

`-m` and `--export-config` generate required files for mySyntenyPortal, `-v 0` just silences the output.  

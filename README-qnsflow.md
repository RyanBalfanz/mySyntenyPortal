# QNS-MSP Dataflow Documentation

## Purpose  
The goal of QNS-MSP is to integrate the files generated from qns directly into MSP. With this integration a single simple script can be used to kick off the following processes,

* Run QNS with .links and .tab files
* Create .synteny and .size files
* Generate .conf files for MSP
* Setup and launch MSP
* Load diagram from .conf file using .synteny and .size files.

## Installation

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


## Usage


Make sure you are in the `mySyntenyPortal` directory

Then run the `run-from-qns.sh` script with the following format:  

`./run-from-qns.sh [.links filename] [.tab filename]`

**TODO: adjust `run-from-qns.sh` to accept some (all?) qns parameters from the command line instead of deciding them in the script**

Note that this script expects the filenames of files in the /qns directory, therefore the full path is not required. Also, note that the .tab file is optional, the diagram will still generate without them.

**TODO: review this, maybe it makes more sense to have path from `mySyntenyPortal/` instead of `qns/`**

Currently, run the script without the tab files because the script doesn’t support multiple .tab files which limits its usefulness.

### Example Usage
Here are some example usages:

`./run-from-qns.sh Tse_Allig.links`  
`./run-from-qns.sh Tse_Goph.links`  

## Notes
`./run-from-qns.sh` currently passes the flags `-o ./output/ -v 0 -m --export-config`.

`-m` and `--export-config` generate required files for mySyntenyPortal, `-v 0` just silences the output.

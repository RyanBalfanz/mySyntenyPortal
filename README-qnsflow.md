# QNS-MSP Dataflow Documentation

## Purpose  
The goal of QNS-MSP is to integrate the files generated from qns directly into MSP. With this integration a single simple script can be used to kick off the following processes,

* Run QNS with .links and .tab files
* Create .synteny and .size files
* Generate .conf files for MSP
* Setup and launch MSP
* Load diagram from .conf file using .synteny and .size files.

## Setup

### Installing the Two Projects
Currently this project involves a combination of two existing projects.  

Start by cloning the qns-flow branch from MySyntenyPortal. Then, within that directory (i.e. within MSP) clone qns MSP-flow branch.  
```
git clone https://github.com/calacademy-research/mySyntenyPortal.git
cd mySyntenyPortal
git clone https://github.com/calacademy-research/qns.git
```

The overall structure should be,
```
/MySyntenyPortal-  
	build-docker.sh  
	run-from-qns.sh  
	…  
	/qns-  
		qns  
		build_config.py  
		…
```

### Setting Up MSP
In order for MSP to run properly, build the docker image before running any files. To do so, run the `build-docker.sh` file within the project.

Run `./build-docker.sh`

Note: This may take a while because the container has to install many dependencies, however this is a one-time execution.  

### Setting Up QNS
In order for QNS to run properly, install the necessary requirements. Start by creating a virtual environment and installing the requirements. Run the following commands within the qns directory to do so.  

`cd mySyntenyPortal/qns`  
`python3 -m venv env`  
`source env/bin/activate`  
`pip3 install -r requirements.txt`.   

After setting up the virtual environment with the necessary packages, qns should work properly.

## Usage

### Simple Combined Usage
Once the virtual environment is created and the docker image is built, the combined data flow can be run. Start by navigating to the `/mySyntenyPortal` directory.    

First, ensure you are within the correct python3 environment. If not already within virtual environment, run  

`source qns/env/bin/activate`  

Then run the `run-from-qns.sh` script. With the following format:  

`./run-from-qns.sh [.links filename] [.tab filename]`

Note that this script expects the filenames of files in the /qns directory, therefore the full path is not required. Also, note that the .tab file is optional, the diagram will still generate without them.

Currently, run the script without the tab files because the script doesn’t support multiple .tab files which limits its usefulness.

### Example Usage
Here are some example usages,

`./run-from-qns.sh Tse_Allig.links`  
`./run-from-qns.sh Tse_Goph.links`  

Running from QNS:

QNS_DIRECTORY, usually ~/qns, this is where you cloned the QNS repo.
MSP_DIRECTORY, usually ~/MySyntenyPortal, this is where you cloned MySyntenyPortal.

clone these projects.

cd QNS_DIRECTORY.

Run QNS with the arguments: 
"--export-config  -o <MSP_INPUT_DIRECTORY>"
(there's a good example in all_with_msp.sh).

You now have MSP inputs ready in QNS_DIRECTORY/MSP_INPUT_DIRECTORY.

cd MSP_DIRECTORY

Next, create the directory ./configurations if it doesn't already exist:
mkdir MSP_DIRECTORY/configurations

Copy QNS_DIRECTORY/MSP_INPUT_DIRECTORY/qns.conf to the directory MSP_DIRECTORY/configurations.

Note that there is an existing (as provided by the original authors) "data" directory here
with known good input to compare to. You may want to preserve this for debugging, so 
mv MSP_DIRECTORY/data MSP_DIRECTORY/data.original
if it doesn't exist, create MSP_DIRECTORY/data
if it doesn't exist, create MSP_DIRECTORY/data/example_inputs.

copy QNS_DIRECTORY/MSP_INPUT_DIRECTORY/*.synteny to MSP_DIRECTORY/data/example_inputs
copy QNS_DIRECTORY/MSP_INPUT_DIRECTORY/*.sizes to MSP_DIRECTORY/data/example_inputs


We run MySyntenyPortal in docker. We mount $(PWD) (aka: this directory) as /code inside the docker.

We launch the whole portal with "kick-off-docker.sh". (this name is not ituitive, we should change it).

Kick off docker launches the portal using docker-compose up. And then, inside the container, it does this:

# docker-compose exec sweb perl ./mySyntenyPortal build -conf ./configurations/qns.conf

This looks in ./configurations to pick up qns.conf. qns.conf and all the .synteny files (referenced by
qns.conf) are generated by the qns.py program when the arguments "--export-config  -o <msp_input_directory>"
are used.





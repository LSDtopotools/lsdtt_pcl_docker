#!/bin/bash

# This is a startup script for LSDTopoTools
# It grabs and unpacks the example data
# it then builds the code from there. 
# Author: SMM
# Date: 24/06/2019

# clone or pull the repo, depending on what is in there
# check if the files have been cloned
if [ -f /LSDTopoTools/data/ExampleTopoDatasets/README.asc ]
  then
    echo "You appear to have already downloaded the example datasets."
    echo "If you wish to download a newer version you should delete the ExampleTopoDatasets directory,"
    echo "And then run this script again"
  else
    echo "\n\n========================================"
    echo "I am grabbing the example datasets from the web"
    echo "These files are large (>150Mb)! It will take a little while to download."
    echo "========================================\n\n"
    
    
    if [ -d /LSDTopoTools/data/ ]
      then
        echo "You have the data directory"
      else
        mkdir /LSDTopoTools/data/ 
    fi
        
    cd /LSDTopoTools/data/      
    wget https://github.com/LSDtopotools/ExampleTopoDatasets/archive/master.zip
    unzip master.zip -d /LSDTopoTools/data/
    mv /LSDTopoTools/data/ExampleTopoDatasets-master /LSDTopoTools/data/ExampleTopoDatasets 
    
    # Clean up
    rm master.zip
    
fi
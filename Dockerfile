# This is the LSDTopoTools container that includes the point cloud library (PCL)
# PCL is HUGE. Also it won't compile on the lightweight alpine container so the Linxu build is also large
# This means that this container is *MUCH* larger than the lsdtt-alpine container.
# You should only use this container if you intend to use the components of LSDTopoTools
# that require the point cloud library. 
# These include
#  * The terrace code
#  * Code that includes swath profiling
#  * Any code that includes biomass
# If you are not a developer, the only place you will really encounter PCL is in the terrace code. 
# If you do not plan to use this, we suggest using the lsdtt-alpine container:
# https://hub.docker.com/r/lsdtopotools/lsdtt_alpine_docker/
# For documentation see:
# https://lsdtopotools.github.io/LSDTT_documentation/

# Pull base image.
FROM ubuntu:18.04
MAINTAINER Simon Mudd (simon.m.mudd@ed.ac.uk) and Fiona Clubb (clubb@uni-potsdam.de)

# Need this to shortcut the stupid tzdata noninteractive thing
ARG DEBIAN_FRONTEND=noninteractive

# These are the basic build tools
RUN apt-get update && apt-get install -y \
    apt-utils \
    bash \
    tzdata \
    build-essential \
    git \
    cmake \
&& rm -rf /var/lib/apt/lists/*

# Now some extra bells and whistles
RUN apt-get update && apt-get install -y \
    gdal-bin \
    libfftw3-dev \
    python-gdal \
&& rm -rf /var/lib/apt/lists/*

# And this is the point cloud library

# install pcl
RUN apt-get update && apt-get install -y \
    libpcl-dev \
&& rm -rf /var/lib/apt/lists/*

# Install some projection tools
RUN apt-get update && apt-get install -y \
    libproj-dev \
&& rm -rf /var/lib/apt/lists/*

# Install some simple scripts for zipping and fetching things from the internet
RUN apt-get update && apt-get install -y \
    wget \
    unzip \  
&& rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /LSDTopoTools

# Copy the startup script
COPY Start_LSDTT.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/Start_LSDTT.sh

# Copy the script for fetching example data 
COPY Get_LSDTT_example_data.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/Get_LSDTT_example_data.sh


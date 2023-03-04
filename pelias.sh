#!/bin/bash
set -x

# change directory to the where you would like to install Pelias
# cd /path/to/install

# clone this repository
git clone https://github.com/pelias/docker.git --recursive docker
cd docker

# install pelias script
# this is the _only_ setup command that should require `sudo`

# cd into the project directory
cd projects/south-africa

# create a directory to store Pelias data files
# see: https://github.com/pelias/docker#variable-data_dir
# note: use 'gsed' instead of 'sed' on a Mac
mkdir -p ./data/pelias/pelias_za
gsed -i '/DATA_DIR/d' .env
echo 'DATA_DIR=./data/pelias/pelias_za' >> .env

# run build
pelias compose pull
pelias elastic start
pelias elastic wait
pelias elastic create
pelias download all
pelias prepare all
pelias import all
pelias compose up

# optionally run tests
pelias test run

#!/bin/bash

echo "-- Install packages --" && sleep 3
sudo apt-get install -y gstreamer1.0-tools gstreamer1.0-nice gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good libgstreamer1.0-dev libglib2.0-dev libgstreamer-plugins-bad1.0-dev libsoup2.4-dev libjson-glib-dev
sudo apt-get install ubuntu-restricted-extras ffmpeg
echo "Done !" && sleep 2

sudo mkdir /home/opts && cd /home/opts

echo "---- Cloning vcpkg repository ----" && sleep 3

sudo git clone https://github.com/Microsoft/vcpkg.git

cd /home/opts/vcpkg && sudo bash ./bootstrap-vcpkg.sh -useSystemBinaries

sudo /home/opts/vcpkg/vcpkg install boost

cd /home

echo "---- Cloning WebRTCController repository ----" && sleep 3

sudo rm -rf WebRTCController

sudo git clone https://github.com/dspip/WebRTCController 

cd WebRTCController

VERSION=$(cat VERSION)

sudo echo "'Version :'${VERSION}'Jenkins Build :'.${BUILD_NUMBER}" | sudo tee VERSION

sudo mkdir build 

cd build

sudo cmake .. -DCMAKE_TOOLCHAIN_FILE=/home/opts/vcpkg/scripts/buildsystems/vcpkg.cmake

sudo cmake --build . --config Release --target all -- -j 6 

sudo make install

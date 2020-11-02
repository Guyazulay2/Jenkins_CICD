#!/bin/bash



echo "---- SSH to the client server -----"
cd /home/ubuntu/
ssh -i /home/ubuntu/new.pem -o StrictHostKeyChecking=no ubuntu@$ip '

pwd

echo "** Install Nvidia Packages **" ; sleep 3

if [ "$(dpkg -l | awk '/cuda-10-2/ {print }'|wc -l)" -ge 1 ]; then

        echo "--- Cuda exists ---!"
        sleep 1
else

        echo -e "Cuda Not installed !\n installing now cuda 10.2 >>"
        wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
        sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
        wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
        sudo dpkg -i cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
        sudo apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
        sudo apt-get update
        sudo apt-get -y install cuda
        echo "Done !"
        sleep 2

fi

if [ "$(dpkg -l | awk '/nvidia-docker2/ {print }'|wc -l)" -ge 1 ]; then

        echo "--- Nvidia-Docker2 exists ---!"
        sleep 1
else

        echo -e "Nvidia-Docker-2 not exsist ! installing now ... >>"
        sleep 2
        distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
        curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
        curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
        sudo apt-get update && sudo apt-get install -y nvidia-docker2
        sudo systemctl restart docker
        sleep 2; nvidia-smi
        
       echo "******* Reboot Now *********"
       reboot

fi


sudo systemctl restart docker
echo "----------Installation done -------------" ; sleep 2
nvidia-smi

sudo git clone https://github.com/dspip/PeopleDetector.git -b peoplenet_latest /home/PeopleDetector/

echo "--- Build the Dockerfile ---"

sudo docker build -t peoplenet /home/PeopleDetector/ && pwd
sudo nvidia-docker run --name peoplenet -it -d -p 4000-4003:4000-4003/udp -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /PeopleDetector peoplenet && sleep 3
sudo docker ps -a && sudo docker images
sudo docker logs peoplenet '

Choose 1 of those docker_files >:
1 | ubuntu
2 | apache
3 | nginx




#!/bin/bash


if [ $choose == "1" ]
then
	
	docker build -t ubuntu_$name /home/guy/ubuntu/
	sudo docker run -d ubuntu_$name
    	sudo docker ps -a
	
    	sudo docker login --username=$username --password=$pass
    	
	ID=`docker images --filter=reference=ubuntu_$name --format "{{.ID}}"`

    	sudo docker tag $ID $username/ubuntu_$name:ubuntu_$name

	sudo docker push $username/ubuntu_$name
    
	
elif [ $choose == "2" ]
then
	
    docker build -t apache2_$name /home/guy/apache2/
    sudo docker run -d -p $port apache2_$name
    sudo docker ps -a
    
    IP=`ip addr show enp0s3 |egrep 'inet '| awk '{print $2}'| cut -d '/' -f1`
    PORT=`sudo docker ps -a | awk 'NR==2' | cut -d ":" -f2 | cut -d "-" -f1`
    STATUS=$(curl -s -o /dev/null -w '%{http_code}' $IP:$PORT)
    
    if [ $STATUS -eq 200 ]; then
    	echo "Got 200 ! all done !"
        
    	sudo docker login --username=$username --password=$pass
    	ID = `docker images --filter=reference=ubuntu_$name --format "{{.ID}}"`
    	sudo docker tag $ID $username/apache2_$name:apache2_$name
    	sudo docker push $username/apache2_$name
    else
    	echo "Got $STATUS :Not done yes.."
    fi
    

elif [ $choose == "3" ]
then
	
    docker build -t nginx_$name /home/guy/nginx/
    sudo docker run -d -p $port nginx_$name
    sudo docker ps -a
	
    IP=`ip addr show enp0s3 |egrep 'inet '| awk '{print $2}'| cut -d '/' -f1`
    PORT=`sudo docker ps -a | awk 'NR==2' | cut -d ":" -f2 | cut -d "-" -f1`
    STATUS=$(curl -s -o /dev/null -w '%{http_code}' $IP:$PORT)
    
    if [ $STATUS -eq 200 ]; then
    	
    	echo "Got 200 ! all done !"
    	ID=`docker images --filter=reference=nginx_$name --format "{{.ID}}"`
    	sudo docker login --username=$username --password=$pass
   		
    	sudo docker tag $ID $username/nginx_$name:nginx_$name
    	sudo docker push $username/nginx_$name
    
    else
    	echo "Got $STATUS Failed , Not done yes.."
    
    fi

fi

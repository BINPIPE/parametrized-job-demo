#!/bin/bash

# Script meant to be invoked via Jenkins to Demonstrate end-to-end CI/CD
# Author: Prasanjit Singh //www.binpipe.org//nixgurus@gmail.com

#------------------------------------------------------------------#

echo "*******-Starting CI CD Pipeline Tasks-*******"
#-BUILD
echo ""
echo "..... Build Phase Started :: Compiling Source Code :: ......"
#compilation not needed here as code is html 

#workdir=${PWD##*/}
#
#if [ "$workdir" == "foldername" ]; then
#  echo "correct folder"
#else
# echo "incorrect folder"
#fi
#cd $workdir

#-BUILD (TEST)
echo ""
echo "..... Test Phase Started :: Testing via Automated Scripts :: ......"
echo 
#You can add your real test cases/scripts here!
echo "Dummy test cases running !! ..." ; sleep 10;
echo "Completed!"

#----------------------------------------#

echo ""
echo "..... Integration Phase Started :: Copying Artifacts :: ......"
chmod +x wrapper.sh
echo ""
echo "..... Provisioning Phase Started :: Building Docker Container :: ......"
docker build --tag parametrized-job-demo .
#if there is a public docker repository push it to public repo here-
#sudo docker push binpipe/parametrized-job-demo


#-POSTBUILD (PROVISIONING DEPLOYMENT)
CONTAINER=parametrized-job-demo
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "'$CONTAINER' does not exist."
else
  docker rm -f $CONTAINER
fi

    # run your container
    echo ""
	echo "..... Deployment Phase Started :: Building Docker Container :: ......"
	docker run -d -p 8888:80 --name parametrized-job-demo parametrized-job-demo


#-Completion
echo "--------------------------------------------------------"
echo "View App deployed here: http://server-ip:8888"
echo "--------------------------------------------------------"

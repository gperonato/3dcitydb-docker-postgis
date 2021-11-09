#!/bin/bash
#-----------------------------------------------------------------------------
# 3DCityDB PostGIS Docker Image Quickstart Script ----------------------------
# Contact: Bruno Willenborg <b.willenborg@tum.de
# Chair of Geoinformatics, Technical University of Munich (TUM)
# Modified by Giuseppe Peronato, Idiap Research Institute, <gperonato@idiap.ch>
#-----------------------------------------------------------------------------

# Greetings ------------------------------------------------------------------
cat <<EOF

########################################################################################
## 3DCityDB PostGIS Docker Image Quickstart Script #####################################
########################################################################################

Welcome to the 3DCityDB PostGIS Docker Image Quickstart Script. This script will 
guide you through the process of setting up a 3DCityDB Docker Container. It is going
to create a 3DCityDB PostGIS Docker image of a specific version from the Docker file
in this repository and a 3DCityDB PostGIS Docker container based on the configuration
parameters requested during this script.

Please follow the instructions of the script.
  Enter the required parameters when prompted and press ENTER to confirm.
  Only press ENTER when prompted to use the default value.

########################################################################################


EOF

# Check, IF Docker engine is running -----------------------------------------
docker info > /dev/null
if [ "$?" != "0" ]; then 
  echo
  echo '!!!!! WARNING !!!!! ############################################################'
  echo 'Docker seems not to be installed or running.'
  echo 'Please make sure Docker is up and runnung and retry. Use the "docker info" command to check if Docker is operational.'
  echo 'Help on setting up Docker can be found here: https://docs.docker.com/install/'
  echo
  echo 'Press ENTER quit.'
  echo '################################################################################'
  read
  exit 
fi

# Prompt for IMAGENAME, VERSION, CONTAINERNAME, PORT, DBUSER, DBPASSWORD, DBNAME, SRID, SRSNAME ----------------------

# IMAGENAME
echo
echo 'Please enter a NAME for the 3DCityDB PostGIS Docker image. Press ENTER to use default.'
read -p "(default=3dcitydb-postgis): " IMAGENAME
IMAGENAME=${IMAGENAME:-3dcitydb-postgis}


# VERSION
echo
echo 'Please enter a version for the 3DCityDB PostGIS Docker image. Press ENTER to use default.'
read -p "(default=v3.3.1): " VERSION
VERSION=${VERSION:-v3.3.1}

# NETWORKNAME
echo
echo 'Please enter a network for the container. Press ENTER to use default.'
read -p "(default=citydb-network): " NETWORKNAME
NETWORKNAME=${NETWORKNAME:-citydb-network}

# CONTAINERNAME
echo
echo 'Please enter a NAME for the 3DCityDB PostGIS Docker container. Press ENTER to use default.'
read -p "(default=citydb-container): " CONTAINERNAME
CONTAINERNAME=${CONTAINERNAME:-citydb-container}

# PORT
test=0
re='^[0-9]+$'
while [ "$test" = "0" ]; do
  echo
  echo 'Please enter a PORT for the 3DCityDB PostGIS Docker container to listen on. Press ENTER to use default.'
  read -p "(default=5432): " PORT
  PORT=${PORT:-5432}
  
  if ( [[ ! $PORT =~ $re ]] ) || ( [ "$PORT" -lt "1024" ] || [ "$PORT" -gt "65535" ] ); then
    echo "PORT must be numeric and between 1025 and 65535. Please retry."  
  else 
    test=1
  fi
done

# DBUSER
echo
echo 'Please enter a USERNAME for the 3DCityDB. Press ENTER to use default.'
read -p "(default=postgres): " DBUSER
DBUSER=${DBUSER:-postgres}


# DBPASSWORD
echo
echo 'Please enter a PASSWORD for the 3DCityDB. Press ENTER to use default.'
read -p "(default=postgres): " DBPASSWORD
DBPASSWORD=${DBPASSWORD:-postgres}

# DBNAME
echo
echo 'Please enter a DATABASE NAME for the 3DCityDB. Press ENTER to use default.'
read -p "(default=citydb): " DBNAME
DBNAME=${DBNAME:-citydb}

# SRID
test=0
while [ "$test" = "0" ]; do
  echo
  echo 'Please enter the SRID fof the spatial reference system of the 3DCityDB. Press ENTER to use default.'
  read -p "(default SRS=WGS84, SRID=4326): " SRID
  SRID=${SRID:-4326}
  
  if [[ ! $SRID =~ $re ]]; then
    echo "SRID must be numeric. Please retry."  
  else 
    test=1
  fi
done

# SRSNAME
echo
echo 'Please enter the name of the spatial reference system to use for the 3DCityDB. Press ENTER to use default.'
read -p "(default SRS=WGS84, SRSNAME=urn:ogc:def:crs:EPSG::4326): " SRSNAME
SRSNAME=${SRSNAME:-urn:ogc:def:crs:EPSG::4326}

# print settings
cat <<EOF
########################################################################################

Here is a summary of the settings you provided:

Image name:              $IMAGENAME
3DCityDB version:        $VERSION
Container name:          $NETWORKNAME

Container name:          $CONTAINERNAME
Container host port:     $PORT
3DCityDB username:       $DBUSER
3DCityDB password:       $DBPASSWORD
3DCityDB database name:  $DBNAME
3DCityDB SRS SRID:       $SRID
3DCityDB SRS SRSNAME:    $SRSNAME

########################################################################################

EOF
echo 'Trying to build your docker container now...'
docker build -t "$IMAGENAME" "$VERSION"
echo
echo 'Trying to create the network now...'
docker network ls|grep "$NETWORKNAME" > /dev/null || docker network create "$NETWORKNAME"
echo
echo 'Trying to start your docker container now...'
echo
docker run -dit \
    --network "$NETWORKNAME" \
    --name "$CONTAINERNAME" \
    -p $PORT:5432 \
    -e "POSTGRES_USER=$DBUSER" \
    -e "POSTGRES_PASSWORD=$DBPASSWORD" \
    -e "CITYDBNAME=$DBNAME" \
    -e "SRID=$SRID" \
    -e "SRSNAME=$SRSNAME" \
  "$IMAGENAME"

# Did that work?
if [ "$?" = "0" ]; then
  # yes, it works
  echo
  echo 'Good news. It seems your container war started successfully.'
  echo
  echo 'Run "docker ps -a" to check the status of your container. [ running :) | exited :( ]'
  echo 'If the container status is "Exited" run "docker logs $CONTAINERNAME" to get information on errors during startup.'
  echo
  echo '########################################################################################'
  echo
  echo 'Here are some useful Docker commands for this container:'
  echo
  echo "docker ps -a                            List all containers and their current status"
  echo "docker logs -f $CONTAINERNAME         Attach the log of your container, useful for debugging"
  echo "docker exec -it $CONTAINERNAME bash   Get an interactive shell on your container, useful for making changes to the container"
  echo "docker stop $CONTAINERNAME            Stop the container, if you do not need it temporarily"
  echo "docker start $CONTAINERNAME           Start the container, if you need it again"
  echo
  echo '!!!!!! DANGERZONE !!!!!!----------------------------------------------------------------'
  echo "docker rm -f $CONTAINERNAME           Stop if running and remove the container but keep its data"
  echo "docker rm -f -v $CONTAINERNAME        Stop if running and remove the container and ALL its data. This cannot be undone!!"
  echo '!!!!!! DANGERZONE !!!!!!----------------------------------------------------------------' 
  echo
  echo '########################################################################################'
  echo  
  echo 'Press ENTER to quit.'
  read
  exit
else
  # no, something bad happened
  echo
  echo 'Oh no! Something went wrong. Inspect the error message above to get a clue on what happend.'
  echo
  echo '########################################################################################'
  echo
  echo 'Press ENTER to quit.'
  read
  exit
fi

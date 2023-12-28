# Theme Park Ride

Building a Spring Boot application with github actions.  

This is a demo app to practice DevOps.

# For tech staff

## Copy the git repo in your machine

Create a directory and launch the following command lines in your new directory:  
From ssh :  
`git clone git@github.com:PaulineGB/datascientest-theme-park.git`  
From https :  
`git clone https://github.com/PaulineGB/datascientest-theme-park.git`

## Initialise the docker container

`cd datascientest-theme-park`  
`docker-compose up -d`

## Check api routes

GET http://localhost:5000/ride  
POST http://localhost:5000/ride  
GET http://localhost:5000/ride/{id}  
GET http://localhost:5000/actuator/health/

## Documentation

The project documentation is available on the git repot wiki :  
https://github.com/PaulineGB/datascientest-theme-park/wiki

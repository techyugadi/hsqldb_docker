# hsqldb_docker
Dockerfile and other required files to build and run a HSQLDB server image.
HSQLDB is a lightweight relational database that maps all data in a database to a files on your local file system and runs on Java. It is suitable for dev and test environments. More info at : http://hsqldb.org/

#Dockerhub

A docker using this Dockerfile has already been published to dockerhub at :

techyugadi/hsqldb


# Build

To build your docker using the Dockerfile in this repository copy the Dockerfile  and hsqldb.jar to the same directory on your local machine and run:

sudo docker build -t="your_user/hsqldb" . 

(Replace your_user by your user name)

We have user HSQLDB v2.3.2 here. Replace the jar with a newer one if available.

# Run

To run the docker directly from the image on Docker Hub, execute the command:

sudo docker run -d -p mapped_port:9001 techyugadi/hsqldb

(HSQLDB server runs in the container on port 9001. This port has been exposed in our Dockerfile. Map container port 9001 to a suitable mapped_port on the docker host.)

This starts a HSQLDB server running in a docker, with an empty database named 'starterdb'. The database can be accessed with super-user privileges, using user-name 'SA' with a blank password. The data for this database will be stored in the files /data/starterdb*.

PLEASE NOTE: The directory /data is specified as a VOLUME in our Dockerfile. This enables you to persist the data on the host file system.

You can create a database with your preferred name and data file prefix, when starting up the docker. However, it is recommended that you keep the data file within the /data directory, so that you get the benefits of using Volume. For example:

docker run -it -p 9001:9001 techyugadi/hsqldb --database.0 file:/data/mydb --dbname.0 mydb

You can also create a database with your chosen super-user and password. The way to do this is to pass the database parameters as a server.properties file to HSQLDB (please see HSQLDB documentation). To run your docker in this fashion, you can use a command like:

docker run -it -p 9001:9001 -v /home/user/dbtest/server.properties:/server.properties techyugadi/hsqldb --props /server.properties

Here you are bind-mounting the server.properties file onto /server.properties in the container. The --props option gets passed on to the command line to start HSQLDB.

Your server.properties should include the database URL with preferred user-name and password, as follows:

server.database.0=file:/data/testdb;user=testuser;password=testpswd

server.dbname.0=testdb

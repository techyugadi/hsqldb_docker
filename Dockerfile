FROM azul/zulu-openjdk:7
MAINTAINER TechYugadi <techyugadi@gmail.com>

#Create lib directory for HSQL binaries
RUN /bin/mkdir -p /lib

#Create a volume for database data
VOLUME ["/data"]

#Copy HSQL jar
ADD hsqldb.jar /lib/hsqldb.jar

#Expose Default Port on which db server runs
EXPOSE 9001

#Fixed part of the command to run (to start HSQLDB server)
ENTRYPOINT ["java","-cp", "/lib/hsqldb.jar", "org.hsqldb.server.Server"] 

#Default command line options (creates an empty db called starterdb)
CMD ["--database.0", "file:/data/starterdb", "--dbname.0", "starterdb"]

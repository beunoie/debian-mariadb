#########################################
#VARIABLES: CAN BE EDITED
#########################################

CONTAINER=debian-mariadb

CONTNAME=$(CONTAINER)-1

DATAVOLUME=/Users/20000652/Docker/$(CONTAINER)/vol

#net=host: mandatory for others containers to connect to mysql
STARTOPT=-d \
-p 3306:3306 \
-v $(DATAVOLUME)/db:/var/lib/mysql \
-v $(DATAVOLUME)/bkp:/root/mysqlbkp \
--name $(CONTNAME) \
$(CONTAINER)


#########################################
# ACTIONS: DO NOT EDIT BEYOND THIS POINT
#########################################

build:
	docker build -t $(CONTAINER) .

run:
	docker run $(STARTOPT)

bash:
	docker exec -i -t $(CONTNAME) /bin/bash

stop:
	docker stop $(CONTNAME)

delete:
	docker rm $(CONTNAME)

clear:
	docker rmi -f $(CONTAINER)

install:
	docker run --restart=always $(STARTOPT)

cleanupdb:
	make stop;make delete && sudo rm -r $(DATAVOLUME)/*

restart:
	 make stop;make delete ;make build ;make run

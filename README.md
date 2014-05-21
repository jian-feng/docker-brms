docker-brms
===========

use to build docker image of JBoss BRMS 6 for quick test

First at all, thanks for [Kenneth's great work](http://www.ossmentor.com/2014/05/docker-and-red-hat-jboss-data.html).


### How to build:
1. Install Docker by following instruction from docker.io

  https://www.docker.io/gettingstarted/#h_installation

2. Clone this git repository to your local disk

```sh
  git clone https://github.com/jian-feng/docker-brms.git
```

3. Run build script

```sh
  cd docker-brms
  sudo ./build.sh
```

4. Confirm the docker image

```Shell
  sudo docker images
```

  Result is: 
```
  REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
  brms601             base                8598341dfc5d        About an hour ago   1.517 GB
```

### How to run:
1. Run docker image in background
```sh
sudo docker run -d -P brms601:base /home/jboss/startall.sh
```

2. Display log of container
```sh
sudo docker ps
```

  Result is: 
```
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                                                                                                                        NAMES
fdfd47577a50        brms601:base        /home/jboss/startall   About an hour ago   Up About an hour    0.0.0.0:49185->8080/tcp, 0.0.0.0:49186->9990/tcp
```

```sh
sudo docker logs -f (above CONTAINER ID)
```
* use CTRL + c to quite. Container will keep running.

3. Access BRMS Business Central

```sh
http://(Docker hostname):(brms601:base container port)/business-central
```

  * Docker hostname : Host name or IP addr where your docker installed
  * brms601:base container port : PORTS that displayed in step 2, ex, 49185
  * log in user is admin, password is Admin123!. You can change it in Dockerfile then build image again.

### How to stop:
1. Find CONTAINER ID
```sh
  sudo docker ps
```
  Result is: 
```
  CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                                                                                                                        NAMES
  fdfd47577a50        brms601:base        /home/jboss/startall   About an hour ago   Up About an hour    0.0.0.0:49185->8080/tcp, 0.0.0.0:49186->9990/tcp
```

2. Run docker stop
```sh
  sudo docker stop (above CONTAINER ID)
```

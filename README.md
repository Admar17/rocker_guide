# rocker_guide

## In the beginning

Keaton and Avery spent hours and hours trying to get this stuff to work. We may be doofuses, but it took us a great deal of time, effort, and frustration to get R, sparklyr, spark, docker, etc. to work well together. We hope this repo saves you from the dark side. As for us, we are long gone.

There are many potential avenues to go down, like the [Spark from R book](https://github.com/jozefhajnala/sparkfromr_docker) or random images on [Docker Hub](https://hub.docker.com/r/datawookie/rstudio-sparklyr/). There are many dead ends because of a multitude of reasons:
 - There are many outdated images on Docker Hub
 - Some images on Docker Hub simply didn't work for us
 - Some images just have way to much installed and that can cause difficulties later on

## Its Docker images all the way down

![](images/turtles.png)

We decided to build our own Dockerfile, pulling coding from other Dockerfiles that seemed to have parts of what we needed. When writing a new Dockerfile, you will rarely start from scratch. Start from a **base image**, which is generally from a verified publisher like RStudio.
Many images are built upon simpler images, for example:

- [Base R](https://hub.docker.com/r/rocker/r-ver/dockerfile)
- [RStudio](https://hub.docker.com/r/rocker/rstudio/dockerfile)
- [tidyverse](https://hub.docker.com/r/rocker/tidyverse/dockerfile)

## The Dockerfile

Below is the image that we built. It includes all the necessary linuxy stuff, R, the tidyverse, Java, sparklyr, Spark, and a few more packages.

```
# start with the most up-to-date tidyverse image as the base image
FROM rocker/tidyverse:latest

# install openjdk 8 (Java)
RUN apt-get update \
  && apt-get install -y openjdk-8-jdk

# install sparklyr

RUN install2.r --error --deps TRUE sparklyr

# install spark

RUN Rscript -e 'sparklyr::spark_install("3.0.0")'

# change location of spark directory

RUN mv /root/spark /opt/ && \
    chown -R rstudio:rstudio /opt/spark/ && \
    ln -s /opt/spark/ /home/rstudio/

# install a few more R packages for working with databases

RUN install2.r --error --deps TRUE DBI
RUN install2.r --error --deps TRUE RPostgres
RUN install2.r --error --deps TRUE dbplyr
```






First tried this. Didn't work.
```
docker-compose up
```

Then, tried this. That worked for some reason. The command with a space in between `docker` and `compose` is experimental.
```
docker compose up
```










### Potential with AWS

This stuff seems cool, but we didn't have time to dive deep:

- [Using Spark with AWS S3 buckets](https://spark.rstudio.com/guides/aws-s3/)
- [Running sparkylyr on Amazon EMR](https://aws.amazon.com/blogs/big-data/running-sparklyr-rstudios-r-interface-to-spark-on-amazon-emr/)


### Rocker in Japanese

[Go to repo](https://github.com/rocker-jp/tidyverse)


### Adding rocker container to n451 (no spark):

1. Go to your command line and run the following command to pull the existing rocker/tidyverse image from [docker hub](https://hub.docker.com/r/rocker/tidyverse): 

```
docker pull rocker/tidyverse
```

2. Copy the snippet below and paste it at the bottom of your existing docker-compose.yml file. If using VS Code, you may have to install the docker-compose.yml extension. The spacing and what not needs to be exactly right because it is a YAML file.

```yml
rocker:
    image: rocker/tidyverse
    environment: 
      - USER=rstudio
      - PASSWORD=rstudio1234
    depends_on: 
      - db
    ports: 
      - '8787:8787'
    volumes:
      - ./scripts:/home/rstudio/scripts
      - ./scratch:/home/rstudio/scratch
      - ./work:/home/rstudio/work
      - ./data:/home/rstudio/data
    networks: 
      - n451
```
(Will explain the above stuff later)


3. Run the following command in your terminal with your project directory as the working directory: 

```
docker-compose up
```

4. Either enter http://localhost:8787/ in the browser or go to your Docker Desktop app and open in the browser from there.

![](images/docker_screenshot.png)

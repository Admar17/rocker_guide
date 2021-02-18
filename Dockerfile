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
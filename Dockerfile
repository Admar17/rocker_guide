# start with the most up-to-date tidyverse image as the base image
FROM rocker/tidyverse:latest

# install openjdk 8 (Java)
RUN apt-get update \
  && apt-get install -y openjdk-8-jdk

# Install devtools
RUN Rscript -e 'install.packages("devtools")'

# Install sparklyr
RUN Rscript -e 'devtools::install_version("sparklyr", version = "1.5.2", dependencies = TRUE)'

# Install spark
RUN Rscript -e 'sparklyr::spark_install(version = "3.0.0", hadoop_version = "3.2")'

RUN mv /root/spark /opt/ && \
    chown -R rstudio:rstudio /opt/spark/ && \
    ln -s /opt/spark/ /home/rstudio/

RUN install2.r --error --deps TRUE DBI
RUN install2.r --error --deps TRUE RPostgres
RUN install2.r --error --deps TRUE dbplyr



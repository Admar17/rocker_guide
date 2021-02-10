# Sys.setenv(SPARK_HOME = "spark/spark-2.3.0-bin-hadoop2.7/")

library(sparklyr)

sc <- sparklyr::spark_connect(master = 'local')

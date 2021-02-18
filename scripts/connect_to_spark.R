# connect to spark
# https://spark.rstudio.com/guides/connections/

sc <- sparklyr::spark_connect(master = 'local')

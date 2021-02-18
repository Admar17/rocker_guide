# source connection scripts -----------------------------------------------

source('scripts/connect_to_spark.R')
source('scripts/connect_to_database.R')

# load packages -----------------------------------------------------------

# install.packages('tictoc')
# install.packages('janitor')
# install.packages('arrow')

# pre-installed

library(tidyverse)
library(DBI)
library(RPostgres)
library(dbplyr)
library(sparklyr)

# need to install

library(tictoc)
library(janitor)
library(arrow)


# "sc" represents the spark connection
# "con" represents the database connection

dbListTables(con)

# https://dbplyr.tidyverse.org/reference/tbl.src_dbi.html

dat <- tbl(con, 'tmp_990_employees')

glimpse(dat)

tic()
title_comp <- dat %>%
  count(PrsnNm, TtlTxt, CmpnstnAmt) %>% 
  collect()
toc()

title_comp %>% 
  clean_names() %>% 
  rename(title = ttl_txt, comp = cmpnstn_amt) %>% 
  arrange(desc(comp)) %>% 
  head(20)

tic()
dat_spark <- sparklyr::copy_to(sc, dat, "dat")
toc()







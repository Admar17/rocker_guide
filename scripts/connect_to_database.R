library(DBI)
library(RPostgres)

con <- DBI::dbConnect(
  drv = RPostgres::Postgres(),
  dbname = Sys.getenv('POSTGRES_DB_NAME'),
  host = Sys.getenv('POSTGRES_HOST'),
  port = 5432,
  user = Sys.getenv('POSTGRES_USERNAME'),
  password = Sys.getenv('POSTGRES_PASSWORD')
)

dbListTables(con)

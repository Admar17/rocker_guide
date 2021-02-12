



con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "PostgreSQL Driver",
                      #Server   = "[your server's path]",
                      Database = "postgres",
                      UID      = Sys.getenv("POSTGRES_DB_NAME"),
                      PWD      = Sys.getenv("POSTGRES_PASSWORD"),
                      Port     = 5432)

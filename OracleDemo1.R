##외부에서 접속해서 분석할 경우
getwd()
dir.create("../project180722")
setwd("../project180722")
list.files()

### RStudio 와 Oracle 연결
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
library(rJava)
library(DBI)
library(RJDBC)
drv <- JDBC(
  "oracle.jdbc.driver.OracleDriver",
  "C:\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\jdbc\\lib\\ojdbc6.jar"
)
conn <- dbConnect(drv,
                  "jdbc:oracle:thin:@localhost:1521:xe",
                  "joe",
                  "password")
dbGetQuery(conn, "SELECT * FROM TAB")

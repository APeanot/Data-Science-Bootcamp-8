library(RPostgreSQL)
library(tidyverse)
library(lubridate)

# Connecting
con <- dbConnect(PostgreSQL(), 
                 host = "tiny.db.elephantsql.com",
                 port = "5432",
                 user = "swptemxg",
                 password = "9WR-V27pkgu9xXxWZVha5_0l75nX-08C",
                 dbname = "swptemxg")

# Writing Tables
customers <- data.frame(
  customers_id = 1:5,
  name = c("Peanot", "Roger", "Peter", "Melissa", "Rafael"),
  city = c("Bangkok", "London", "New York", "England", "Jerusalem"),
  email = c("peanot@gmail.com", "roger@hotmail.com", "peter@hotmail.com", "melissa@gmail.com", "rafael@hotmail.com")
)  

dbWriteTable(con, "customers", customers)

menus <- data.frame(
  menuid = 1:5,
  menuname = c("Thai Spring Rolls", "Green Papaya Salad", "Red Curry", "Pad Gra Prow", "Thai Iced Coffee"),
  price = c(80.00, 45.00, 70.00, 45.00, 30.00)
)

dbWriteTable(con, "menus", menus)

invoices <- data.frame(
  customerid = 1:5,
  invoicedate = ymd("2023-01-02", "2023-02-25", "2023-02-26", "2023-03-12", "2023-04-09"),
  totalprice = c(125.00, 75.00, 170.00, 115.00, 60.00)
)

dbWriteTable(con, "invoices", invoices)

# Listing Tables
dbListFields(con, "customers")
dbListFields(con, "menus")
dbListFields(con, "invoices")

# Querying
dbGetQuery(con, 
           "select sum(totalprice) from customers join invoices on customers.customers_id = invoices.customerid")

# Disconnecting
dbDisconnect(con)

library(nycflights13)

View(flights)
glimpse(flights)
help(flights)

flights %>%
  filter(month == 2) %>%
  count(carrier) %>%
  arrange(-n) %>%
  head(5)

flights %>%
  filter(month == 2) %>%
  count(carrier) %>%
  arrange(-n) %>%
  head(5) %>%
  left_join(airlines, by = "carrier")

flights %>%
  group_by(carrier) %>%
  summarise(aver_dep_delay = sum(dep_delay, na.rm = TRUE) / n()) %>%
  arrange(aver_dep_delay) %>%
  left_join(airlines, by = "carrier")  %>%
  select(carrier, name, aver_dep_delay) 

flights %>%
  group_by(carrier) %>%
  summarise(aver_arr_delay = sum(arr_delay, na.rm = TRUE) / n()) %>%
  arrange(desc(aver_arr_delay)) %>%
  left_join(airlines, by = "carrier")  %>%
  select(carrier, name, aver_arr_delay)

flights %>%
  group_by(carrier) %>%
  summarise(sum_dis = sum(distance, na.rm = TRUE)) %>%
  arrange(desc(sum_dis)) %>%
  left_join(airlines, by = "carrier") %>%
  head(1)

flights %>%
  group_by(month, carrier, flight) %>%
  summarise(total_at = sum(air_time)) %>%
  arrange(desc(total_at)) %>%
  left_join(airlines, by = "carrier") %>%
  select(month, carrier, name, flight, total_at) %>%
  head()

flights %>%
  group_by(distance) %>%
  select(month, day, origin, dest, air_time, distance) %>%
  arrange(-distance) %>%
  head(3)

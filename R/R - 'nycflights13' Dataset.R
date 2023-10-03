"nycflights13 = Flights that Departed NYC in 2013"

library(nycflights13)

View(flights)
glimpse(flights)
help(flights)

# 1) What is the average delayed flight departing of each airlines?
flights %>%
  group_by(carrier) %>%
  summarise(aver_dep_delay = sum(dep_delay, na.rm = TRUE) / n()) %>%
  arrange(aver_dep_delay) %>%
  left_join(airlines, by = "carrier")  %>%
  select(carrier, name, aver_dep_delay)

# 2) What is the average delayed flight arriving of each airlines? (in descending order)
flights %>%
  group_by(carrier) %>%
  summarise(aver_dep_delay = sum(dep_delay, na.rm = TRUE) / n()) %>%
  arrange(aver_dep_delay) %>%
  left_join(airlines, by = "carrier")  %>%
  select(carrier, name, aver_dep_delay)

# 3) Which airline has the longest total flight distance in 2013?
flights %>%
  group_by(carrier) %>%
  summarise(sum_dis = sum(distance, na.rm = TRUE)) %>%
  arrange(desc(sum_dis)) %>%
  left_join(airlines, by = "carrier") %>%
  head(1)

# 4) Which flight spent the most time in the air, including its carrier and month?
flights %>%
  group_by(month, carrier, flight) %>%
  summarise(total_at = sum(air_time)) %>%
  arrange(desc(total_at)) %>%
  left_join(airlines, by = "carrier") %>%
  select(month, carrier, name, flight, total_at) %>%
  head(1)

# 5) Which are the three longest routes above all?
flights %>%
  group_by(distance) %>%
  select(month, day, origin, dest, air_time, distance) %>%
  arrange(-distance) %>%
  head(3)

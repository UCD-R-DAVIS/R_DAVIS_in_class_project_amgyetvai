# 8.1 and 8.2: Lubridate and Function Writing ----
# 3 time classes: dates, calendar time, and local time

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
class(sample_dates_1)

# the string must be of the form YYYY-MM-DD to convert it into a date format
sample_dates_1 <- as.Date(sample_dates_1)
class(sample_dates_1)

# a complete list pf date-time formats
?strptime

# challenge
as.Date("Jul 04, 2019", format = "%b%d,%Y")

# when working with times POSIXct is the best to work with:
tm1 <- as.POSIXct("2016-07-24 23:55:26")
tm1

tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2

#POSIXct assumes you collected your data in the timezone your computer is set to

# the tidyverse way (a bit easier and tidier):
install.packages("lubridate")
library(lubridate)

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")

# we use ymd since our date is in y-m-d
sample_dates_lub <- ymd(sample_dates_1)
sample_dates_lub

sample_dates_2 <- c("2-01-2018", "3-21-2018", "10-05-18", "01-01-2019", "02-18-2019")
sample_dates_2 <-  mdy(sample_dates_2)
sample_dates_2

# to add time to a date, use functions that add "_hms" or "_hm"
lubridate::ymd_hm("2016-01-01 12:00", tz="America/Los_Angeles")

library(dplyr)
library(readr)

# 8.2 ----
my_sum <- function(a, b){
  the_sum <-  a + b 
  return(the_sum)
}

my_sum
my_sum(a = 2, b = 2)

sum <- my_sum(a = 2, b = 2)

# provide default values
my_sum_2 <- function(a = 1, b = 2){
  the_sum <-  a + b 
  return(the_sum)
}

my_sum_2()
my_sum_2(b = 3)

# temperature conversation example: farenheit to kelvin
((50 - 32) * (5/9)) + 273.15
((72 - 32) * (5/9)) + 273.15

# how to write function:
## 1. identify what pieces will change within your commands (this is your argument)
## 2. remove it and replace it with object names
## 3. place code and argument into the function() function

f_to_k <- function(tempF){
 k <- ((tempF - 32) * (5/9)) + 273.15
}

f_to_k(tempF = 72)

farenheit <- f_to_k(tempF = 72) 

library(tidyverse)
install.packages("gapminder")
library(gapminder)

gapminder %>% 
  filter(country == "Canada", year %in% c(1950:1970)) %>% 
  summarize(mean(gdpPercap, na.rm = T))

avgGDP <- function(cntry, yr.range){
  df <- gapminder %>% 
    filter(country == cntry, year %in% yr.range)
  mean(df$gdpPercap, na.rm = T)
}

avgGDP("Iran", 1980:1985)

avgGDP("Zimbabwe", 1950:2000)

# 8.1 and 8.2: Lubridate and Function Writing ----
# 3 time classes: dates, (posixct) calendar time, and (posixlt) local time

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

#more examples using lubridate:
lubridate::ymd("2016/01/01")# --> 2016-01-01
lubridate::ymd("2011-03-19")# --> 2011-03-19
lubridate::mdy("Feb 19, 2011")# --> 2011-02-19
lubridate::dmy("22051997")# --> 1997-05-22

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
  summarize(mean(gdpPercap, na.rm = TRUE))

avgGDP <- function(cntry, yr.range){
  df <- gapminder %>% 
    filter(country == cntry, year %in% yr.range)
  mean(df$gdpPercap, na.rm = TRUE)
}

avgGDP("Iran", 1980:1985)

avgGDP("Zimbabwe", 1950:2000)

avgGDP("United States", 1980:1995)

#Timezones:
#hms means hours, minutes seconds. 
#to add time to a date, use functions that 
#add "_hms" or "_hm" for hours, mins, secs OR hours, mins
#it's a good idea to combine your date and 
#time into a single column, since
#it represents different sized increments 
#of a single time variable

lubridate::ymd_hm("2016-01-01 12:00", 
                  tz="America/Los_Angeles")
# --> 2016-01-01 12:00:00
#24 hour time:
lubridate::ymd_hm("2016/04/05 14:47", 
                  tz="America/Los_Angeles")
# --> 2016-04-05 14:47:00

#converts 12 hour time into 24 hour time:
latime <- lubridate::ymd_hms("2016/04/05 4:47:21 PM", 
                             tz="America/Los_Angeles") 
latime
#how to change time zones
with_tz(latime, tzone = "GMT")
with_tz(latime, tzone = "Pacific/Honolulu")
# --> 2016-04-05 16:47:21

#make sure your data starts as 
#character strings, not as dates and times, 
#before converting to lubridate
#read_csv will see dates and 
#times and guess that you want them as 
#Date and Time objects, so you have to 
#explicitly tell it not to do this.

library(dplyr)
library(readr)

# read in some data and skip header lines
mloa1 <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
head(mloa1) #R tried to guess for you that 
#the year, month, day, and hour columns were numbers

# import raw dataset & specify column types
mloa2 <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv",
                  col_types = "cccccccddddddddd") # same number of columns that we have for c and the rest are doubles, or d

#notice the difference in the data types of these two objects:
glimpse(mloa1) 
glimpse(mloa2)

# now we are ready to make a datetime col 
#so that we can use lubridate on it:
mloa2$datetime <- paste(mloa2$year, "-", mloa2$month,
                        "-", mloa2$day, ", ", mloa2$hour24, ":",
                        mloa2$min, sep = "")

glimpse(mloa2)
#since we used "paste," our new column is a character string type

#3 options for how to progress from here:
# convert Date Time to POSIXct in local timezone using lubridate

#WARNING!!
#this method as_datetime does not work 
#in this dataset unless you specify
#format, because otherwise it tries to look for 
#seconds but we don't have data for seconds, 
#and there are an inconsistent number of 
#digits for each portion of the datetime 
#(eg month could be "2" or "12")
mloa2$datetime_test <- as_datetime(mloa2$datetime, 
                                   tz="America/Los_Angeles", 
                                   format="%Y-%m-%d, %H:%M")
#note: America/Los_Angeles is not actually 
#the time zone that this data is from,
#which is evident because when telling 
#lubridate to assume the data is from 
#America/Los_Angeles, the 60 datapoints 
#during the switch to daylight savings 
#are parsed as "NA" because that hour didn't actually exist!

# Instead, convert using the ymd_functions
#This method works!
mloa2$datetime_test2 <- ymd_hm(mloa2$datetime, 
                               tz = "Pacific/Honolulu")

# OR wrap in as.character()
mloa1$datetime <- ymd_hm(as.character(mloa2$datetime), 
                         tz="Pacific/Honolulu")
tz(mloa1$datetime)



#how do we extract different components from a lubridate object?
# Functions called day(), month(), year(), 
#hour(), minute(), second(), etc... will 
#extract those elements of a datetime column.
months <- month(mloa2$datetime)

# Use the table function to get a quick 
#summary of categorical variables
table(months)

# Add label and abbr agruments to convert 
#numeric representations to have names
months <- month(mloa2$datetime, label = TRUE, abbr=TRUE)
table(months)

#how to check for daylight savings time
dst(mloa2$datetime_test[1])
dst(mloa2$datetime)

latime <- lubridate::ymd_hms("2016/04/05 4:47:21 PM", 
                             tz="America/Los_Angeles") 
latime
dst(latime)
gm <- with_tz(latime, tzone = "GMT")
dst(gm) 
hi <- with_tz(latime, tzone = "Pacific/Honolulu")
dst(hi) 
# --> 2016-04-05 16:47:21

# Creating Functions ------------------------------------------------------
# Learning Objectives: 
## Define a function that takes arguments
## Set default value for function arguments
## Explain why we should divide programs into small, single-purpose functions



## Defining a function -----------------------------------------------------
# arguments are the input, return values are the output
# for now, we will work with functions that return a single value


# providing argument defaults so you don't have to specify every argument every time (e.g., na.rm = FALSE in mean)








# Process to write your own function --------------------------------------
## temperature conversion example: Farenheit to Kelvin
((50 - 32) * (5/9)) + 273.15
((62 - 32) * (5/9)) + 273.15
((72 - 32) * (5/9)) + 273.15

## How do write function: 
# 1. Identify what piece(s) will change within your commands -- this is your argument
# 2. Remove it and replace with object(s) name(s)
# 3. Place code and argument into the function() function




## Pass-by-value: changes or objects within the function only exist within the function
## what happens in the function, stays in the function 





# source()ing functions ---------------------------------------------------





# Using dataframes in functions -------------------------------------------
# Say you find yourself subsetting a portion of your dataframe again and again 
# Example: Calculate average GDP in a given country, in a given span of years, using the gapminder data




# Challenge ---------------------------------------------------------------
# Write a new function that takes two arguments, the gapminder data.frame (d) and the name of a country (e.g. "Afghanistan"), and plots a time series of the country’s population. The return value from the function should be a ggplot object. Note: It is often easier to modify existing code than to start from scratch. To start out with one plot for a particular country, figured out what you need to change for each iteration (these will be your arguments), and then wrap it in a function.

library(gapminder)

county_plot <-function(cntry){
  d <- gapminder %>% 
    select(country, year, pop) %>% 
    filter(country == cntry) %>% 
    ggplot(aes(x = year, y = pop)) +
    geom_point()
 return(d)
}
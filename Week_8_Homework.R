# Week 8 Assignment ----
library(tidyverse)
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
mloa
head(mloa)
mloa

library(lubridate)

# With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s. 
tz(mloa) # this does not return what I was looking for -> it shows UTC
?strptime
View(mloa)
glimpse(mloa)

# Generate a column called “datetime” using the year, month, day, hour24, and min columns.
# Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). 
mloa_edited <- mloa %>% 
  filter(!is.na(rel_humid)) %>% 
  filter(!is.na(temp_C_2m)) %>% 
  filter(!is.na(windSpeed_m_s)) %>% 
  mutate(date_time = paste0(mloa$year, "-",
                                  mloa$month, "-",
                                  mloa$day, ",",
                                  mloa$hour24, ":",
                                  mloa$min),
                            tz = "UTC") %>% 
  mutate(datetimeLocal = with_tz(date_time, tz = "Pacific/Honolulu")) # I used paste0() instead of paste() and this finally worked!
           
?dplyr
library(dplyr)

# Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). 
?month
?hour
library("RColorBrewer")

# Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.  
mloa_edited %>% 
  mutate(local_month = month(datetimeLocal, label = TRUE),
         local_hour = hour(datetimeLocal)) %>% 
  group_by(local_month, local_hour) %>% 
  summarize(mean_temp = mean(temp_C_2m)) %>% 
  ggplot(aes(x = local_month,
         y = local_hour)) +
  geom_point(aes(colour = local_hour)) +
  theme_light() + 
  scale_fill_brewer(palette = "Dark2") +
  xlab("Month") +
  ylab("Mean temperature (degrees C)") 
















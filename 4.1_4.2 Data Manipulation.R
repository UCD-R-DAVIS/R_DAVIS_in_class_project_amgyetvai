# Week 4.1 Data Manipulation 1 ----

library("tidyverse")
# dplyr is great for data table manipulation!
# tidyr helps you switch between data formats

surveys <- read_csv("data/portal_data_joined.csv")

# csv file is comma separated value file

view(surveys)
str(surveys) # useful for an overview of the data set 

## select columns ----
month_day_year <- select(surveys, month, day, year)
month_day_year

## filtering by equals ----
year_1981 <- filter(surveys, year == 1981)

## filtering by range ----
filter(surveys, year %in% c(1981:1983))

# review: why you should never do:
filter(surveys, year == c(1981, 1982, 1983))
# 1685 results ...index level matching in increments of 1, 2, 3 in a pattern

## filtering by multiple conditions ----
bigfoot_with_weight <-  filter(surveys, hindfoot_length > 40 & !is.na(weight))
bigfoot_with_weight

## multi-step process ----
small_animals <-  filter(surveys, weight < 5)
small_animals

small_animals_id <- select(filter(surveys, weight < 5), record_id, plot_id, species_id)
small_animals_id

## same process, using nested functions ----
small_animals_id <- select(filter(surveys, weight < 5), record_id, plot_id, species_id)

## same process, using a pipe ----
# %>%  command shift M
small_animals_id <- filter(surveys, weight < 5) %>% select(record_id, plot_id, species_id)
small_animals_id  

# same as 
small_animals_id <-  surveys %>% filter(weight < 5) %>% select(record_id, plot_id, species_id)
small_animals_id

### line breaks with pipes ----
surveys %>% filter(month==1)

# good:
surveys %>% 
  filter(month==1)
# break lines after open parenthesis, pipe, comma

# Part 2 ----

## Mutate ----
surveys <- surveys %>% 
  mutate(weight_kg = weight/1000)
str(surveys)

## Add multiple columns ----
surveys <- surveys %>% 
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
surveys

## filter out NA's ----
surveys <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)
head(surveys)

## Group by and summarize ----
surveys2 <- surveys %>% group_by(sex) %>% mutate(mean_weight = mean(weight))
summarize(mean_weight = mean(weight))
library(tidyverse)

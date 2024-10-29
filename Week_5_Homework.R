# Assignment 5, Abbey Gyetvai ----

# Part 1 ----
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

# manipulate surveys to create a new dataframe called surveys_wide with a column for genus and a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. 
surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarise(mean_hindfoot = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>% 
  arrange(Control)
surveys_wide  

summary(surveys$weight)
# Part 2 ----
# use the two different functions we laid out for conditional statements, ifelse() and case_when(), to calculate a new weight category variable called weight_cat.

# define the rodent weight into three categories, where “small” is less than or equal to the 1st quartile of weight distribution, “medium” is between (but not inclusive) the 1st and 3rd quartile, and “large” is any weight greater than or equal to the 3rd quartile.

surveys %>% 
  mutate(weight_cat = case_when(
    weight <= 20 ~ "small",
    weight > 20 & weight < 48 ~ "medium",
    weight >= 48 ~ "large"))

surveys %>% 
  mutate(weight_cat = ifelse(weight <= 20, "small", 
                             ifelse(weight > 20 & weight < 48, "medium", "large")))


# Bonus questions ----
summary(surveys$weight)

summ_bonus <- summary(surveys$weight)
class(summ_bonus)
head(summ_bonus)
summ_bonus[[2]]
summ_bonus[5] 

surveys[[2]]

surveys %>% 
  mutate(weight_cat = case_when(
    weight <= summ_bonus[2] ~ "small",
    weight > summ_bonus[2] & weight < summ_bonus[5] ~ "medium",
    weight >= summ_bonus[5] ~ "large"))

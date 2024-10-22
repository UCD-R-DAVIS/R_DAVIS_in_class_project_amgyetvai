# Assignment 4
library(tidyverse)
surveys <- read_csv('data/portal_data_joined.csv')

surveys
# subset surveys to keep rows with weight between 30-60, and print out the first 6 rows
?filter
surveys %>% 
  filter(weight > 30 & weight < 60)

# new tibble with the max weight for each species and sex combination named "biggest_critters" and sort. remove NAs.
biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(max_weight = max(weight))
biggest_critters # this worked! Originally, I tried removing the NAs afterward, but it got tricky. It was best to run all of the functions at the same time.

# arrange in ascending and descending order
biggest_critters %>% 
  arrange(max_weight)

biggest_critters %>% 
  arrange(desc(max_weight))

# using tally and arrange
tally(biggest_critters)
arrange(biggest_critters)

# remove the NAs and add a column for the average weight of species + sex combinations.
surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight)

surveys_avg_weight

# then, remove columns except: species, sex, weight. add new average weight column as "surveys_avg_weight". surveys_avg_weight and add column "above_avg". 
surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_avg = weight > avg_weight)

surveys_avg_weight

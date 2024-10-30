# Midterm, Abbey Gyetvai

library(tidyverse)
URL <- 'https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv'
URL
laps <- read_csv(URL)
laps

# I want to view the data set before I proceed any further.
View(laps)

# Filter out any non-running activities (any pace above 10-minute mile AND any <5-minute mile AND abnormally short records with <1-minute).
true_running_laps <- laps %>% 
  filter(sport == 'running') %>% 
  filter(minutes_per_mile < 10 & minutes_per_mile > 5) %>% 
  filter(total_elapsed_time_s >= 60) %>% 
  mutate(pace = case_when(minutes_per_mile < 6 ~ 'fast', # Create a new categorical variable, "pace", for laps by pace as "fast" (< 6 mins/mile), "medium" (6-8 mins/mile), and "slow" (> 8 mins/mile).
                          minutes_per_mile >= 6 & minutes_per_mile < 8 ~ 'medium',
                          minutes_per_mile > 8 ~ 'slow'), # originally, I got an error for running this because I forgot to add ~ 'slow' to the end of my argument. Once I added this in, it ran accordingly.
         form = case_when(year == 2024 ~ 'new', # Create another categorical variable, "form", to distinguish between laps in 2024 as "new" and anything before 2024 as "old".
                                 TRUE ~ 'old')) 

# I had this all broken up in chunks before, but it was not running properly. So, I added pipes to my functions and it seems to work now!


# Identify the average steps per minute for laps by form and pace, and generate a table showing these values with old and new as separate rows and pace categories as columns. 
# 'slow speed' is the 2nd column, 'medium speed' is the 3rd column, and 'fast speed' is the 4th column.
true_running_laps %>% 
  group_by(form, pace) %>% 
  summarise(avg_steps_per_min = mean(steps_per_minute)) %>% 
  pivot_wider(id_cols = form, values_from = avg_steps_per_min, names_from = pace) %>% 
  select(form, slow, medium, fast)

# Summarize the minimum, mean, median, and maximum steps per minute results for all laps (regardless of pace category) run between January - June 2024 and July - October 2024 for comparison.
mean(true_running_laps$steps_per_minute)
median(true_running_laps$steps_per_minute)
max(true_running_laps$steps_per_minute)

# this data above is summarized from ALL of the laps, with no dates distinguished. I wasn't sure how to tackle this part of the problem!
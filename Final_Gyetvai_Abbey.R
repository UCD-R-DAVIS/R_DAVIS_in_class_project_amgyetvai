# Final Exam, Abbey Gyetvai ----

library(tidyverse)
library(ggplot2)

# 1. Read in the file tyler_activity_laps_12-6.csv from the class github page. This file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.
URL <- "https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv"
URL
tyler_activity_laps <- read_csv(URL)
View(tyler_activity_laps) # I checked to make sure the dataset properly loaded. It did! 
head(tyler_activity_laps)

# 2. Filter out any non-running activities.
running_activites_only <- tyler_activity_laps %>% 
  filter(sport == "running")
head(running_activites_only) 
View(running_activites_only) # Again, I checked to make sure this worked properly. It did, because the entries in tyler_activity_laps was 9,039 entries, and in running_activities_only, there are 8,533 entries.

# 3. We are interested in normal running. You can assume that any lap with a pace above 10 minutes_per_mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute_per_mile pace) and abnormally short records where the total elapsed time is one minute or less.
normal_running <- running_activites_only %>% 
  filter(minutes_per_mile > 5 & minutes_per_mile < 10) %>% 
  filter(total_elapsed_time_s > 60)
head(normal_running)
View(normal_running) # Again, I checked to see if this worked and it lowered the total entries from running_activities_only (9,039 entries) to 6,983 entries for normal_running.

# 4. Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.
library(lubridate)
library(dplyr)

normal_running %>% 
  mutate(Time_Period = case_when(
    timestamp < ymd("2024-01-01") ~ "Pre-2024 Running", # 1st time period
    timestamp >= ymd("2024-01-01") & timestamp <= ymd("2024-06-30") ~ "Rehab Efforts, Jan.-Jun. 2024",
# 2nd time period
    timestamp >= ymd("2024-07-01") ~ "Present" # 3rd time period
  ))
View(normal_running) # this didn't seem to mutate the columns. I will try to use the seconds to correct this

normal_running <- normal_running %>% 
  mutate(timestamp = as_date(timestamp))
View(normal_running) # I did some Googling and referred to my notes, and determined using the as_date() function could remove the hour, minute, seconds. If I rerun the above code, this should work!

normal_running <- normal_running %>% 
  mutate(Time_Period = case_when(
    timestamp < ymd("2024-01-01") ~ "Pre-2024 Running", # 1st time period
    timestamp >= ymd("2024-01-01") & timestamp <= ymd("2024-06-30") ~ "Rehab Efforts, Jan.-Jun. 2024",
    # 2nd time period
    timestamp >= ymd("2024-07-01") ~ "Present" # 3rd time period
  ))
View(normal_running) # Great! This seemed to work. Additionally, I noticed I never renamed the dataset to update the changes, so now it does work properly.

# 5. Make a scatter plot that graphs SPM over speed by lap. 6. Make 5 aesthetic changes to the plot to improve the visual.
ggplot(normal_running, aes(x = minutes_per_mile, y = steps_per_minute)) +
  geom_point(alpha = 0.6, color = "orange") +
  theme_light() +
  labs(title = "SPM over Speed by Lap",
       x = "Minutes per Mile",
       y = "Steps per Minute")

# Add linear (i.e., straight) trendlines to the plot to show the relationship between speed and SPM for each of the three time periods (hint: you might want to check out the options for geom_smooth()).
ggplot(normal_running, aes(x = minutes_per_mile, y = steps_per_minute, color = Time_Period)) +
  scale_color_brewer(palette = "Set2") +
  geom_point(alpha = 0.6) +
  theme_light() +
  labs(title = "SPM over Speed by Lap",
       x = "Minutes per Mile",
       y = "Steps per Minute") +
  geom_smooth() 

# this is as far as I got in the allotted time period. 

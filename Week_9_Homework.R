# Week 9 Assignment ----
library(tidyverse)

# 1. Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.
surveys <- read.csv("data/portal_data_joined.csv")
View(surveys)

for(i in unique(surveys$taxa)) {
  mytaxon <- surveys[surveys$taxa == i,]
  longestnames <- mytaxon[nchar(mytaxon$species) == max(nchar(mytaxon$species)),] %>% select(species)
  print(paste0("The longest species name(s) among ", i, "s is/are: "))
  print(unique(longestnames$species))
}


mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
View(mloa)

# 2. Use the map function from purrr to print the max of each of the following columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.
new_columns <- mloa %>%
  select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")
new_columns %>% 
  map(max, na.rm = TRUE)

# 3. Make a function called C_to_F that converts Celsius to Fahrenheit. Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. Bonus: can you do this by using map_df? Don’t forget to name your new columns “temp_F…” and not “temp_C…”!
C_to_F <- function(x){
  x * 1.8 + 32
}

?mutate # I had to refresh myself on the mutate function

mloa_new_columns <- mloa %>%
  mutate(
    temp_F_2m = C_to_F(mloa$temp_C_2m),
    temp_F_10m = C_to_F(mloa$temp_C_10m),
    temp_F_towertop = C_to_F(mloa$temp_C_towertop),
    )
View(mloa_new_columns) # Yay! It worked!

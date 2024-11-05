# 5.1 Data Manipulation and Conditional Statements ----
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

summary(surveys$hindfoot_length)

# pseudocode
# ifelse(test or condition, what to do if the test is yes/true, what to do if it's false/no)

## boolean test ----
surveys$hindfoot_length < 29.29

surveys$hindfoot_categorical <- ifelse(surveys$hindfoot_length < 29.29, yes = "small", no = "big")
head(surveys$hindfoot_categorical)
head(surveys$hindfoot_length)
surveys$hindfoot_length <- ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")
head(surveys$hindfoot_categorical)
unique(surveys$hindfoot_categorical)

# if else is helpful for 2 conditions
## case_when() ----
surveys %>%
  mutate(hindfoot_categorical = case_when(
    hindfoot_length > 29.29 ~ "big",
    is.na(hindfoot_length) ~ NA_character_, #NA_character is R's way of knowing that it is NA
    TRUE ~ "small" # weird syntax! But essentially the "else" part
  )) %>% 
  select(hindfoot_length, hindfoot_categorical) %>%
  head()

## more categories? ----
surveys %>%
  mutate(hindfoot_categorical = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_, #NA_character is R's way of knowing that it is NA
    TRUE ~ "small" # weird syntax! But essentially the "else" part
  )) %>% 
  select(hindfoot_length, hindfoot_categorical) %>%
  
  
  group_by(hindfoot_categorical) %>% 
  tally()

surveys

# 5.2 Data Manipulation: Joins and Pivots ----
library(tidyverse)
tail <- read_csv('data/tail_length.csv')
head(tail)
dim(tail)

# pseudocode join_function(data frame a, data frame b, how to join)
# inner_join(data frame a, data frame b, common id)
surveys <- read_csv('data/portal_data_joined.csv')
dim(inner_join(x = surveys, y = tail, by = 'record_id')) # only keep the dimensions that are the same in both 
dim(surveys)
dim(tail)
tail

surveys_inner <- inner_join(x = surveys, y = tail)
head(surveys_inner)

all(surveys$record_id %in% tail$record_id)
?all # are all values true?

all(tail$record_id %in% surveys$record_id)


## left_join and right_join ----
# left join takes dataframe x and dataframe y and it keeps everything in x and only matches in y
# left_join(x, y) == right_join(y, x)
# right join takes dataframe x and dataframe y and it keeps everything in y and only matches in x
# right_join(x, y) == left_join(y, x)

surveys_left_joined <- left_join(x = surveys, y = tail, by = 'record_id')
surveys_left_joined

surveys_right_joined <- right_join(x = surveys, y = tail, by = 'record_id')
surveys_right_joined
dim(surveys_left_joined)
dim(surveys_right_joined)

table(is.na(surveys_left_joined$tail_length))

## full_join ----
# full_join keeps EVERYTHING! fills in NAs where there are no corresponding values 
surveys_full_joined <- full_join(x = surveys, y = tail)
dim(surveys_full_joined) # dim() function is your friend here!

tail %>% 
  select(-record_id)

dim(surveys_full_joined)

left_join(surveys, tail %>% 
            rename(record_id2 = record_id),
          by = c('record_id' = 'record_id2'))

## pivots ---- will be on the midterm!
# pivot_wider makes data with more columns
pivot_wider()
# pivot_longer makes data with more rows
pivot_longer

surveys_mz <- surveys %>% # calc mean weight by genus and plot id 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight)) 

surveys_mz
unique(surveys_mz$genus)

wide_survey <- surveys_mz %>% 
  pivot_wider(names_from = 'plot_id', 
              values_from = 'mean_weight',
              id_cols = 'genus')
wide_survey

head(wide_survey)

surveys_long <- wide_survey %>% pivot_longer(-genus, names_to = 'plot_id', values_to = 'mean_weight')
head(surveys_long)

# In-Class Work ----
# Conditional statements ---- 
## ifelse: run a test, if true do this, if false do this other thing
## case_when: basically multiple ifelse statements
# can be helpful to write "psuedo-code" first which basically is writing out what steps you want to take & then do the actual coding
# great way to classify and reclassify data

## Load library and data ----
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

## ifelse() ----
# from base R
# ifelse(test, what to do if yes/true, what to do if no/false)
## if yes or no are too short, their elements are recycled
## missing values in test give missing values in the result
## ifelse() strips attributes: this is important when working with Dates and factors

mean(surveys$hindfoot_length, na.rm = FALSE) # gives an NA in the output, so because we have NAs, we have to remove it 

surveys %>% 
  mutate(hindfoot_categorical = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_,
    TRUE ~ "small" # don't need a comma at the end because there are no more tests, TRUE is a catch-all
  )) %>% 
  select(hindfoot_length, hindfoot_categorical) %>% 
  head(10)

## case_when() ----
# GREAT helpfile with examples!
# from tidyverse so have to use within mutate()
# useful if you have multiple tests
## each case evaluated sequentially & first match determines corresponding value in the output vector
## if no cases match then values go into the "else" category

# case_when() equivalent of what we wrote in the ifelse function
surveys %>%
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big", # hindfoot length over mean (29.29), I want to be reclassified as "big"
    TRUE ~ "small" # else part of the statement 
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()

?summarise
?summary

# but there is one BIG difference - what is it?? (hint: NAs)



# if no "else" category specified, then the output will be NA


# lots of other ways to specify cases in case_when and ifelse
surveys %>%
  mutate(favorites = case_when(
    year < 1990 & hindfoot_length > 29.29 ~ "number1", 
    species_id %in% c("NL", "DM", "PF", "PE") ~ "number2",
    month == 4 ~ "number3",
    TRUE ~ "other"
  )) %>%
  group_by(favorites) %>%
  tally()
?tally
  
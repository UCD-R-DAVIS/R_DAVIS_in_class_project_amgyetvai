# Tutorials ----
## How R Thinks about Data ----
### Vectors and Data Types ----

weight_g <- c(50, 60, 65, 82)
weight_g

animals <- c("mouse", "dog", "cat")
animals

# length tells you how many elements are in a vector:
length(weight_g)
length(animals)

# class tells you the type of element of an object:
class(weight_g)
class(animals)

### Subsetting Vectors ----
animals <- c("mouse", "rat", "dog", "cat")
animals[2] # means return the second value in animals

### Conditional Subsetting ----
weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)] # could be seen as give the first value, not the second, etc.

weight_g > 50

#### The function %in% allows you to test if any of the elements of a search vector are found: ----
animals %in% c("rat", "cat", "dog", "duck", "goat")

#### You can add the argument na.rm=TRUE to calculate the result while ignoring the missing values. ----
heights <- c(2, 4, 4, NA, 6)
heights
max(heights)
mean(heights, na.rm = TRUE)

#### If your data include missing values, you may want to become familiar with the functions is.na(), na.omit(), and complete.cases() ----

#Extract those elements which are not missing values.

is.na(heights) # this returns a logical vector with TRUE where there is an NA

!is.na(heights) # the ! means "is not", so now we get a logical vector with FALSE for NAs

heights[!is.na(heights)] # now we put that logical vector in, and it will NOT return the entries with NA

## Starting with Spreadsheets ----
surveys <- read.csv("data/portal_data_joined.csv")
surveys
class(surveys)

### Inspecting data.frame Objects ----

#### Size ----
nrow(surveys) # returns the number of rows
ncol(surveys) # returns the number of columns

#### Content ----
head(surveys) # shows the first 6 rows
tail(surveys) # shows the last 6 rows
View(surveys) #  opens a new tab in RStudio that shows the entire data frame. Useful at times, but you shouldn’t become overly reliant on checking data frames by eye, it’s easy to make mistakes

#### Names ----
colnames(surveys) # column names
rownames(surveys) # row names

#### Summary ----
str(surveys) # structure of the object and information about the class, length and content of each column
summary(surveys) # summary statistics for each column

### Indexing and Subsetting ----
# first three elements in the 7th column (as a vector)
surveys[1:3, 7]

# the 3rd row of the data frame (as a data.frame)
surveys[3, ]   

# equivalent to head_surveys <- head(surveys)
head_surveys <- surveys[1:6, ] 
head_surveys

#### : is a special function that creates numeric vectors of integers in increasing or decreasing order; try running 1:10 and 10:1 to check this out. You can also exclude certain indices of a data frame using the “-” sign: ----

surveys[, -1] # The whole data frame, except the first column

surveys[-c(7:34786), ] # Equivalent to head(surveys)

# Manipulating and analyzing data in the tidyverse, Part 1 ----

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

### Selecting columns and filtering rows ----
select(surveys, plot_id, species_id, weight)
filter(surveys, year == 1995)

### filter is used for rows and select is used for columns. ----

### Pipes ----
surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

### Mutate ----
# Frequently you’ll want to create new columns based on the values in existing columns, for example to do unit conversions, or to find the ratio of values in two columns. For this we’ll use mutate().
surveys %>%
  mutate(weight_kg = weight / 1000)

surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000) %>%
  head()

### Group by and summarize ----
# group_by() is often used together with summarize(), which collapses each group into a single-row summary of that group. group_by() takes as arguments the column names that contain the categorical variables for which you want to calculate the summary statistics
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

# Manipulating and analyzing data in the tidyverse, Part 2 ----
summary(surveys$hindfoot_length)

#### We will first do this using the ifelse() function, where the first argument is a TRUE/FALSE statement, the second argument is the new variable if the statement is true, and the third argument is the new variable if the statement is false. ----

surveys$hindfoot_categorical <- ifelse(surveys$hindfoot_length < 29.29, "small", "big")
head(surveys$hindfoot_cat)

url <- 'https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv'
lap_dt <- read_csv(url)

running_laps <- lap_dt %>% 
  filter(sport == 'running') %>%
  filter(total_elapsed_time_s >= 60) %>%
  filter(minutes_per_mile < 10 & minutes_per_mile > 5) %>%
  mutate(pace_cat = case_when(minutes_per_mile < 6 ~ 'fast',
                              minutes_per_mile >=6 & minutes_per_mile < 8 ~ 'medium',
                              T ~ 'slow'),
         form = case_when(year == 2024 ~ 'new form',
                          T ~ 'old form'))
running_laps

# Data Visualization ----
library(tidyverse)
surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))

## Plotting with ggplot2 ----
# ggplot2 is a plotting package that makes it simple to create complex plots from data in a data frame.
## basic template: ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>() ----

ggplot(data = surveys_complete)
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

## add ‘geoms’ – graphical representations of the data in the plot (points, lines, bars). ----

# * `geom_point()` for scatter plots, dot plots, etc. ----
# * `geom_boxplot()` for, well, boxplots! ----
# * `geom_line()` for trend lines, time series, etc. ----

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

## Building your plots iteratively ----
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)

# add color
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")




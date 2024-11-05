# 6.1 Data Visualization ----

# ggplot2 ----

## Grammar of Graphics plotting package (included in tidyverse package - you can see this when you call library(tidyverse)!)
## easy to use functions to produce pretty plots
## ?ggplot2 will take you to the package helpfile where there is a link to the website: https://ggplot2.tidyverse.org - this is where you'll find the cheatsheet with visuals of what the package can do!

## ggplot basics
## every plot can be made from these three components: data, the coordinate system (ie what gets mapped), and the geoms (how to graphical represent the data)
## Syntax: ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPING>))

## tips and tricks
## think about the type of data and how many data  variables you are working with -- is it continuous, categorical, a combo of both? is it just one variable or three? this will help you settle on what type of geom you want to plot
## order matters! ggplot works by layering each geom on top of the other
## also aesthetics like color & size of text matters! make your plots accessible 


## example ----
library(tidyverse)
library(ggplot2)
## load in data
surveys <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.)) # remove all NA's

surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))

# syntax for ggplot
# ggplot(data = <DATA>, mapping = aes(<MAPPING>)) + <GEOM_FUNCTION>()

# example
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

# add geom_function
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

# add more plot elements
# add transparency to the points
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)

# add color to the points
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(color = "blue", alpha = 0.1)

# color cheatsheet: https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf

# color by group
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(aes(color = genus)) + 
  geom_smooth(aes(color = genus))

# universal plot setting 
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = genus)) +
  geom_point() +
  geom_smooth()

# box plot: categorical x continuous data ----
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(color = "orange")

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(fill = "orange") + 
  geom_jitter(color = "black", alpha = 0.1)

# change the order of plot construction
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(color = "black", alpha = 0.1) +
  geom_boxplot(fill = "orange", alpha = 0.5)

## Let's look at two continuous variables: weight & hindfoot length
## Specific geom settings
# add layers to the plot
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
 geom_smooth()

## Universal geom settings
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length, color = genus)) +
  geom_point() +
  geom_smooth()

surveys <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.))
head(surveys_complete %>% 
  count(year, species_id))

head(surveys_complete %>% 
       group_by(year, species_id) %>% 
       tally())

yearly_counts <- surveys_complete %>% 
  count(year, species_id)
head(yearly_counts)

ggplot(data = yearly_counts, 
       mapping = aes(x = year, y = n)) +
  geom_line()

ggplot(data = yearly_counts, 
       mapping = aes(x = year, y = n, group = species_id)) +
  geom_line(aes(colour = species_id)) +
  geom_point()

ggplot(data = yearly_counts[yearly_counts$species_id%in%c('BA', 'DM', 'DO', 'DS'),] 
       mapping = aes(x = year, y = n, group = species_id)) +
  geom_line() +
  facet_wrap(~species_id) +
  scale_y_continuous(name = 'obs', breaks = seq(
    0, 600, 100
  ))

theme_bw() # changes the background color
library(ggthemes)
install.packages("ggthemes")
library(ggthemes)

install.packages("tigris")
install.packages("sf")

ca_counties = tigris::counties(state = 'CA',
                               class = 'sf')
ca_counties
ggplot(data = ca_counties) +
  geom_sf(aes(fill = -ALAND)) + theme_map() +
  scale_fill_continuous_tableau()

# 6.2 ----
yearly_counts <-  surveys_complete %>% 
  count(year, species_id)
yearly_counts

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_point()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id, color = species_id)) +
  geom_line()

# faceting
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id, nrow = 4)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id, ncol = 4)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id, scales = 'free')







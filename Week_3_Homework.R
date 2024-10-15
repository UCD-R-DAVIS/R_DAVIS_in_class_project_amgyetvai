# Week 3 Homework ----
library(tidyverse)

surveys <- read.csv("data/portal_data_joined.csv")

# I wanted to look at the structure of the surveys 
str(surveys)
colnames(surveys)

surveys_base <- surveys[1:5000, c(6, 9, 13)]
surveys_base

# Removing NAs from the data using !is.na did not work, so I tried using the complete.cases function instead
surveys_base <- surveys_base[complete.cases(surveys_base), ]
surveys_base

# Converting to species_id and plot_id to factors
surveys_base$species_id <- factor(surveys_base$species_id)
surveys_base$species_id

surveys_base$plot_type <- factor(surveys_base$plot_type)
surveys_base$plot_type

levels(surveys_base$species_id)
levels(surveys_base$plot_type)

# Type of factors
typeof(surveys_base$species_id)
typeof(surveys_base$plot_type)

class(surveys_base$species_id)
class(surveys_base$plot_type)

# Challenge. Initially, I was confused, but I viewed by surveys_base table and figured it out.
View(surveys_base)
challenge_base <- surveys_base[surveys_base[, 2] > 150 , ]
challenge_base

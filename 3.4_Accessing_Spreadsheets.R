# Accessing Spreadsheets ----
surveys <- read.csv("data/portal_data_joined.csv")
str(surveys)
surveys
class(surveys)
?read.csv

getwd()
str(surveys)



nrow(surveys)
ncol(surveys)

head(surveys)
tail(surveys)
?head
?tail
head(surveys, n = 3)
surveys[c(1, 5, 24, 3001),]

summary(surveys)
summary(surveys$record_id)
surveys$sex
?summary
summary.data.frame(surveys)

surveys[1, 5]
surveys[1:5,]
surveys[,1:5]
head(surveys, 1)
surveys['record_id']
surveys[c('record_id', 'year', 'day')]

surveys[1,] # all of the columns in the first row
surveys[,1] # give the first column of vectors 
surveys[1]
head(surveys[,1])

surveys[1:3,] # a simple way to make a sequence

1:10
surveys[1:10,]

surveys[, 1:3]

surveys[1:3, 1:3]

surveys[c(1, 4, 10), c(2, 4, 6)]

surveys[, -1]

surveys[-1]

surveys[-c(7:nrow(surveys)),]
nrow(surveys) == 34786

head(surveys) # for viewing the top of the data
head(surveys, n = 10) # use n = to view a specific amount of the numbers 
tail(surveys)
surveys[1:6,]

class(head(surveys["genus"])) # single bracket calls a data frame
class(head(surveys[, "genus"]))
head(surveys[["genus"]]) # double bracket brings a vector, gets to the internal object living within the object
head(surveys['genus',]) # this will be wrong because it is treating genus as the rows when it is a column
head(surveys[,'genus']) # this is correct

surveys$record_id
surveys$genus

install.packages('tidyverse')
library(tidyverse) # must call the libary(tidyverse) function on each new script

t_surveys <-  read_csv('data/portal_data_joined.csv')
class(t_surveys) # it is still a data frame with slightly nicer additions in it called a tibble (stramlined data)

t_surveys

surveys[,1]
t_surveys[,1]

class(surveys$hindfoot_length)
surveys$plot_id # $ is only for columns, not for rows 


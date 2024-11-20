# Week 9.1 and 9.2 Videos ----

#9.1 For Loops ----

# Iteration Learning Objectives: understand when/why to iterate code
# Start with a single use and build up to iteration
# Use for loops and map functions to iterate

# Data Upload
head(iris)
head(mtcars)

# Subsetting refresher ----
# square brackets for indexing 
iris[1]
iris[[1]]
iris$Sepal.Length

iris[,1]
iris[1,1]
iris$Sepal.Length[1]

# For Loops ----
# when you want to do something down rows of data
# takes an index value and runs it through your function
# layout: use of i to specify index value (although you could use any value here)

for (i in 1:10) {
  print(i)
}

for (i in 1:10) {
  print(iris$Sepal.Length[i])
}
head(iris$Sepal.Length, n = 10) # this is the same as above!

for (i in 1:10) {
  print(iris$Sepal.Length[i])
  print(mtcars$mpg[i])
}

# Store Output ----
results <- rep(NA, nrow(mtcars)) # can highlight nrow(mtcars) and get 32!
results

for (i in 1:nrow(mtcars)){
  results[i] <-  mtcars$wt[i] * 100
}
results
mtcars$wt

# 9.2 ----
# Map Family of Functions ----
# map functions are useful when you want to do something across multiple columns
library(tidyverse)
# two arguments: the data and the function

map(iris, mean) # the default output is a list
map_df(iris, mean)

head(mtcars)

print_mpg <- function(x, y){
  paste(x, "gets", y, "miles per gallon")
}

# additional map function: map2_chr(input1, input2, function)
map2_chr(rownames(mtcars), mtcars$mpg, print_mpg)

# embed an anonymous function <- this gets the same result as above
map2_chr(rownames(mtcars),
         mtcars$mpg,
         function(x, y) paste(x, "gets", y, "miles per gallon"))







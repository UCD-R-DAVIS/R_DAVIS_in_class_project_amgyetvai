# Introduction to R
3 + 4

# incomplete 
2 * 

# order of operations
4  (8 * 3) ^ 2

# this is a comment

# scientific notation
2 / 100000
4e3

#mathematical functions
exp(1)

exp(3)

log(4)

sqrt(4)

# r help files --- they are a helpful way to navigate
?log
log(2, 4)
log(4, 2)
log(x = 2, base = 4)

x <- 1
x
rm(x)

# note:
#?? searches the text of all R help files, e.g., ? 

# nested functions
sqrt(exp(4))
log(exp(100))

# six comparison functions
mynumber <- 6

# two equal signs!! one equal sign will assign a vector name 
mynumber == 5

mynumber > 4

mynumber < 3

mynumber >= 2

mynumber <= -1

#objects and assignment
mynumber <- 7

othernumber <- -3

mynumber * othernumber

# object name conventions
num_samples <- 50

# errors and warnings
log_of_word <- log("a_word")
log_of_word

log_of_negative <- log(-2)


# challenge
elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb <-  elephant1_kg * 2.2
elephant2_lb > elephant1_lb

myelephants <- c(elephant1_lb, elephant2_lb)

myelephants

which(myelephants == max(myelephants))




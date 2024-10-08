set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

# I wanted to know what set.seed meant.
?set.seed

# I used Google how to remove NA from a set of data, and I also used the tutorial guide for more information.
prob1 <- hw2[!is.na(hw2)]
prob1

# I wanted to know specifically what is.na meant.
?is.na

prob1 <- prob1[prob1 > 14 & prob1 < 38]
prob1

times3 <- prob1 * 3
times3

plus10 <- times3 + 10
plus10

# I asked Tara in drop-in lab for help and she directed me to review indexing. From here, I used TRUE, FALSE to alternate the numbers.
final <- plus10[c(TRUE, FALSE)]
final


# 3.2 Missing Data ----
NA # special character
NaN # Not a number

"NA" # do NOT use quotes for NA values 

heights <- c(2, 4, 4, NA, 6)
heights
mean(heights)
max(heights)
sum(heights)
mean(heights, na.rm = TRUE)
mean(heights, na.rm = T)

is.na(heights)
!is.na(heights)

heights[!is.na(heights)]

heights[complete.cases(heights)]
?complete.cases

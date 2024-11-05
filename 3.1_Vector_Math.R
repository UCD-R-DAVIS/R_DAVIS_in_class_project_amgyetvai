# Vector Math ----
x <- 1:10
x

x + 3
x * 10

y <- 100:109
y
x + y
cbind(x, y, x + y)
?cbind
z <- 1:2
z
x + z
cbind(x, z, x + z)

z <-  1:3
z
cbind(x, z, x + z)

a <- x + z
x[c(TRUE, FALSE)]
x[c(TRUE, FALSE, FALSE)]

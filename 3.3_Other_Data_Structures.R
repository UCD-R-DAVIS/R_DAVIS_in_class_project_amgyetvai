# Week 3 Other Data Structures ----

## Lists ----
list(4, 6, "dog") # list is where you store everything 
?c
c(4, 6, "dog") #
a <-  list(4, 6, "dog")
class(a)
str(a)

b <- list(4, letters, "dog")
b
str(b)
length(b)
length(b[[2]])

## Data Frames ---- # most common type of data structures
letters
data.frame(letters)
df <-  data.frame(letters)
df
as.data.frame(t(df))

length(df)
dim(df) # 26 rows, 1 column
nrow(df)
ncol(df)
df2 <- data.frame(letters, letters)
df2
str(df2)

str(df2)
dim(df2)

data.frame(letters, "dog")
data.frame(letters, 1)
data.frame(letters, 1:2)
data.frame(letters, 1:3)

## Matrices ----
matrix(nrow = 10, ncol = 10)
matrix(1:10, nrow = 10, ncol = 10, byrow = TRUE)
m <- matrix(1:10, nrow = 10, ncol = 10, byrow = TRUE)
m[1, 3]
m[c(1, 2), c(5, 6)]

## Arrays ----

## Factors ----
response <- factor(c("no", "yes", "maybe", "no", "maybe", "no"))
class(response)
levels(response) # different response rates
nlevels(response)
typeof(response)
response

animals <- factor(c("pigs", "duck", "duck", "goose", "goose")) 
animals
class(animals)
levels(animals)
nlevels(animals)

animals <- factor(x = animals, levels = c("goose", "pigs", "duck"))
animals

response <- factor(response, levels = c("yes", "maybe", "no"))
response

year <- factor(c(1978, 1980, 1934, 1979))
year
class(year)
as.numeric(year)
levels(year)

as.numeric(animals)


## Convert ----
as.character(response)

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
year_fct
as.numeric(year_fct)
as.numeric(as.character(year_fct))

## Renaming ----
levels(response)
levels(response)[1] <- "YES"
response

levels(response) <- c("YES", "MAYBE", "NO")
response

# Assignment 6 
library(tidyverse)
library(ggplot2)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

# 1. First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)
gapminder
View(gapminder)

gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% #calculating the mean life expectancy for each continent and year
  ggplot() +
  geom_point(aes(x = year, y = mean_lifeExp, color = continent)) + # creates a scatter plot
  geom_line(aes(x = year, y = mean_lifeExp, color = continent)) # creates a line plot



# 2. Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?
?geom_smooth
?scale_x_log10 # I looked into the help files for both geom_smooth and scale_x_log10. 
# geom_smooth adds a trend line to the data set, while scale_x_log10 also makes data easier to interpret with trend lines.

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# 3. Create a boxplot that shows the life expectancy for Brazil, China, El Salvador, Niger, and the United States, with the data points in the background using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.
view(gapminder)


selected_countries <- c("Brazil", "China", "El Salvador", "Niger", "United States")

gapminder %>% 
  filter(country %in% selected_countries) %>% 
  ggplot(aes(x = country, y = lifeExp)) +
  geom_boxplot() +
  geom_jitter(aes(color = "red")) +
  ggtitle("Life Expectancy of Five Countries") +
  xlab("County") + ylab("Life Expectancy")
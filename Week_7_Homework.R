# Week 7 Assignment  ----
library(tidyverse)
library("RColorBrewer")
gapminder

# I read through all of the directions and looked into facet_wrap() more in-depth, as per Q. 3.
?facet_wrap

assignment_7 <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year > 2000) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% 
  mutate(pop_change_0207 = `2007` - `2002`)

assignment_7 %>% 
  ggplot(aes(x = reorder(country, pop_change_0207), y = pop_change_0207)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free") +
  theme_light() + # I changed my specific theme after browsing through the various ones.
  scale_fill_brewer(palette = "Dark2") + # I selected the "Dark2" color palette after browsing (see code below).
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        legend.position = "none") +
  xlab("Country") + ylab("Change in Population Between 2002 and 2007")

display.brewer.all(colorblindFriendly = TRUE)

# I need to remove the Oceania continent from this plot. I copied and pasted my code to continue tweaking it. 
assignment_7 %>% 
  filter(continent != "Oceania") %>% # filtering to remove any Oceania countries/the continent from my plot.
  ggplot(aes(x = reorder(country, pop_change_0207), y = pop_change_0207)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free") +
  theme_light() + 
  scale_fill_brewer(palette = "Dark2") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        legend.position = "none") +
  xlab("Country") + ylab("Change in Population Between 2002 & 2007")

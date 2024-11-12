# Data Visualization ----
library(tidyverse)
library(ggplot2)

# 7.1 ----
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point()

## all-over color ----
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(color = "red")

## color by variable ----
ggplot(diamonds, aes(x = carat, y = price, color = clarity)) +
  geom_point(alpha = 0.1)

## plotting best practices ----
# remove backgrounds, redundant labels, borders,
# reduce colors and special effects,
# remove bolding

ggplot(diamonds, aes(x = carat, y = price, color = clarity)) +
  geom_point(alpha = 0.2) + theme_classic()

# add a title and labels, and regression lines
ggplot(diamonds, aes(x = carat, y = price, color = clarity)) +
  geom_point(alpha = 0.2) + theme_classic() +
  ggtitle("Price by Diamond Quality") + ylab("Price in $") + stat_smooth(method = "lm") #lm = linear model

# add a LOESS trendcurve for each color
ggplot(diamonds, aes(x = carat, y = price, color = clarity)) +
  geom_point(alpha = 0.2) + theme_classic() +
  ggtitle("Price by Diamond Quality") + ylab("Price in $") + stat_smooth(method = "loess")

# 7.2 ----
#There are 4 types:
#1. continuous
#2: ordinal/sequential (for plotting least to most of something, with zero at one end)
#3: qualitative (for showing different categories)
#4: diverging (for plotting a range from negative values to positive values, with zero in the middle)

install.packages("RColorBrewer")
library("RColorBrewer")
display.brewer.all(colorblindFriendly = TRUE)

## Continuous data ----
ggplot(diamonds, aes(x = clarity, y = carat, color = price)) +
  geom_point(alpha = 0.2) + theme_classic() +
  scale_color_viridis_c(option = "C", direction = -1)

## Ordinal (discrete sequential) ----
ggplot(diamonds, aes(x = cut, y = carat, fill = color)) +
  geom_boxplot() + theme_classic() +
  ggtitle("Diamond Quality by Cut") +
  scale_fill_viridis_d("color") # _d for discrete, _b for bin, and _c continuous!

ggplot(diamonds, aes(x = cut, y = carat, color = color)) +
  geom_boxplot() + theme_classic() +
  ggtitle("Diamond Quality by Cut") +
  scale_color_viridis_d("color")

## on a barplot ----
ggplot(diamonds, aes(x = clarity, fill = cut)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5),
        plot.title = element_text(hjust = 0.5)) +
  scale_fill_viridis_d("cut", option = "B") +
  theme_classic() +
  ggtitle("Diamonds")

# from RColorBrewer
ggplot(diamonds, aes(x = cut, y = carat, fill = color)) +
  geom_boxplot() + theme_classic() +
  ggtitle("Diamond Quality by Cut") +
  scale_fill_brewer(palette = "PuBuGn") 

ggplot(diamonds, aes(x = cut, y = carat, fill = color)) +
  geom_boxplot() + theme_classic() +
  ggtitle("Diamond Quality by Cut") +
  scale_fill_brewer(palette = "PuRd") 

# how did we know the name of the palette "PuRd"? From this list:
display.brewer.all(colorblindFriendly = TRUE)

# from RColorBrewer:
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, fill = Species)) +
  geom_point(shape = 23, color = "black", size = 4) +
  theme_classic() +
  ggtitle("Sepal and Petal Length of Three Iris Species") +
  scale_fill_brewer(palette = "Set2")

# palette name list:
display.brewer.all(colorblindFriendly = TRUE)

# from the ggthemes package:
install.packages("ggthemes")
library(ggthemes)
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = species)) + geom_point() + theme_classic() +
  ggtitle("Sepal and Petal Length of Three Iris Species") +
  scale_color_colorblind("Species") +
  xlab("Sepal Length in cm") +
  ylab("Petal Length in cm")

# manual palette design ----
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
names(cbPalette) <- levels(iris$Species)
cbPalette <- cbPalette[1:length(levels(iris$Species))]

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point() + theme_classic() + ggtitle("Sepal and Petal Length of Three Iris Species") +
  scale_color_manual(values = cbPalette) +
  xlab("Sepal Length in cm") +
  ylab("Petal Length in cm")

# Diverging discrete
# from RColorBrewer
myiris <- iris %>% group_by(Species) %>% 
  mutate(size = case_when(
    Sepal.Length > 1.1 * mean(Sepal.Length) ~ "very large",
    Sepal.Length < 0.9 * mean(Sepal.Length) ~ "very small",
    Sepal.Length < 0.94 * mean(Sepal.Length) ~ "small",
    Sepal.Length > 1.06 * mean(Sepal.Length) ~ "large",
    TRUE ~ "average"
  ))
myiris$size <- factor(myiris$size, levels = c(
  "very small", "small", "large", "very large"
))

ggplot(myiris, aes(x = Petal.Width, y = Petal.Length, color = size)) +
  geom_point(size = 2) + theme_grey() +
  ggtitle("Petal Size & Sepal Length") +
  scale_color_brewer(palette = "RdYlBu")

display.brewer.all(colorblindFriendly = TRUE)

# 7.3 ----
mybarplot <- ggplot(diamonds, aes(x = clarity)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5)) +
  theme_classic() +
  ggtitle("Number of Diamonds by Clarity")

mybarplot

install.packages("BrailleR")
library(BrailleR)

VI(mybarplot)

install.packages("Sonify")
2

# Publishing Plots and Saving Figures and Plots ----
install.packages("cowplot")
library(cowplot)

# make a few plots:
plot.diamonds <- ggplot(diamonds, aes(clarity, fill = cut)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5))
plot.diamonds

plot.cars <- ggplot(mpg, aes(x = cty, y = hwy, colour = factor(cyl))) + 
  geom_point(size = 2.5)
plot.cars

plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species)) +
  geom_point(size=3, alpha=0.7, shape=21)
plot.iris

# use plot_grid
panel_plot <- plot_grid(plot.cars, plot.iris, plot.diamonds, labels=c("A", "B", "C"), ncol=2, nrow = 2)

panel_plot

# fix the sizes draw_plot
fixed_gridplot <- ggdraw() + draw_plot(plot.iris, x = 0, y = 0, width = 1, height = 0.5) +
  draw_plot(plot.cars, x=0, y=.5, width=0.5, height = 0.5) +
  draw_plot(plot.diamonds, x=0.5, y=0.5, width=0.5, height = 0.5) + 
  draw_plot_label(label = c("A","B","C"), x = c(0, 0.5, 0), y = c(1, 1, 0.5))

fixed_gridplot

# Saving Figures and Plots
ggsave("figures/gridplot.png", fixed_gridplot)
1

# interactive web applications
install.packages("plotly")
library(plotly)

plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species)) +
  geom_point(size=3, alpha=0.7, shape=21)

plotly::ggplotly(plot.iris) #it's as simple as that! 







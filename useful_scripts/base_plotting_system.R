# Beautiful graphs in R using base system (^.^)

# It is not so simple to make graphics, it requires an abstraction of business knowledge, with a technique
# to build good graphics

# In R you can make some beautiful graphics using an package called graphics.
# You can make:  Barplots, bubleeplot, pizzaplot, areaplot, dispersionplot and etc...

# The graphics are construct in Shapes: 
# 1. Theme
# 2. Coordinates
# 3. Statistics
# 4. Facets
# 5. Geometries
# 6. Aesthetics
# 7. Data

#------------------------------------------------------------------------------------------------

# We have some arguments to make it, like: points, lines, colors, sizes,...

### Some examples of important args of plots
# Types os points;
# 1 - circle
# 2 - triangule inverse
# 3 - star
# > others (untill 25)

# Types lines:
# 1 - trace line with patterns - small and large, like _ __ _
# 2 - trace line with pattern - small and large, like __ __ __
# 3 - trace line with pattern - small and large, like . __ . __. __
# ...

# Sizes (1, 2, 3, ...)
# Colors ("red", "blue", "pink", ...)

#------------------------------------------------------------------------------------------------

# The grammar of graphics ~.~ 
# Please you can find more in http://hadley.nz/ (Hadley Wickman)

# Examples of graphics 
demo("graphics")

# Básic plot

# Data
x = 1:100
y = 1/(1:100)

plot(x,y, main ="Title", xlab="X-lab", ylab= "Y-lab",lty=3, lwd=2, col="red", type ="l", pch = 1)

# Some descriptions
#xlab - rename X-lab
#ylab - rename Y-lab
#lty - change line of graphic
#col - change color
#type - type of line
#pch - type of point

# Using dataframe
plot(mtcars)
plot(x = mtcars$cyl, y = mtcars$disp, main = "Title", col.main = 52, cex.main = 1.5)

#Histogram
hist(mtcars$wt, main = "Test", xlab = "X-lab", ylab = "Y-lab")
grid(col = 3)

#boxplot
boxplot(mtcars$wt ~mtcars$cyl, main = "Test", xlab = "X-lab", ylab = "Y-lab")
grid(col = 3)

# How add others object in created graphics plot():
# lines() -> points() -> texts() and title() 

plot(x,y)
lines(y)
points(y+1, col ="red") # You can see more in ?plot


# How to join two plots
# mfrow and mfcool

?par
par() # All parameters os plottings area -  default
par('pch')
par('lty')

# Four plots together:

par(mfrow = c(2,2), col.axis = "red") # Where c(row, column)
plot(x,y)
plot(x,y)
plot(x,y)
plot(x,y)

# colors default in R:
colors()
plot(iris$Sepal.Length, iris$Sepal.Width, col = "violetred1")
plot(iris$Sepal.Length, iris$Sepal.Width, col = "antiquewhite")

# complement - You can use plotrix, its a complement of packages basis in R
library(plotrix)
par(mfrow = c(1,1), col.axis ="red")
plot(1:100, las = 2)
ablineclip(v = 6)
ablineclip(h = 6)

# Join two plot inside other
par(mar=c(4,3,3,3), col.axis =  "black")

plot(cars$speed, type = "s", bty = "n", ann = F, col = "red")
axis(side =4)
text(20,85, "Velocity", cex=0.85, col = "red")
par(new = T)
plot(cars$dist, type = "s", bty = "n", ann = F, col = "darkblue", axes =F)
axis(side =4)
text(37,18, "Distance", cex=0.85, col = "darkblue")
title(main = "Velocity x Distance")

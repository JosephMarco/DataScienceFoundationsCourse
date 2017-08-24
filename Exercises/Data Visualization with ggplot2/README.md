# Data-Visualization-with-ggplot2
This repository is dedicated to the Data Visualization exercise for ggplot2 as part of the Foundations of Data Science Course.

First step is looking at the structure to see the format, is it tidy or not? Next we want to use ggplot to plot distribution of the sexes. The aesthetics are continually tweaked throughout the steps below and in the attached R code, to try different visualizations and see what viz shows the best interpretation. At the end we want to know which age groups were most likely to survive in addition to class. Since I fall in the 20-30 age bracket and am a male, it appears i have a higher likely hood of survival, fortunately!!

# Directions from Data Camp:
You've watched the movie Titanic by James Cameron (1997) again and after a good portion of sobbing you decide to investigate whether you'd have a chance of surviving this disaster.

To start your investigation, you decide to do some exploratory visualization with ggplot(). You have information on who survived the sinking given their age, sex and passenger class.

Instructions
1 - Have a look at the str() of the titanic dataset, which has been loaded into your workspace. Looks like the data is pretty tidy!
2 - Plot the distribution of sexes within the classes of the ship.
Use ggplot() with the data layer set to titanic.
Map Pclass onto the x axis, Sex onto fill and draw a dodged bar plot using geom_bar(), i.e. set the geom position to "dodge".
3 - These bar plots won't help you estimate your chances of survival. Copy the previous bar plot, but this time add a facet_grid() layer: . ~ Survived.
4 - We've defined a position object for you.
5 - Include Age, the final variable.
Take plot 3 and add a mapping of Age onto the y aesthetic.
Change geom_bar() to geom_point() and set its attributes size = 3, alpha = 0.5 and position = posn.jd.
Make sure that Sex is mapped onto color instead of fill to correctly color the scatter plots. (This was discussed in detail here and here).

# Data-Visualization-with-ggplot2-part-2-
This repository is dedicated to the Data Visualization exercise (part 2) for ggplot2 as part of the Foundations of Data Science Course. The course focuses on chapters that ultimately are combined into the solidified R script as part of this repository. We wrap all the necessary code into a function (mosaicGG) so that we can run the function over a variety of data sources as part of various R packages.

# Directions from Data Camp:
Now that you've done all the steps necessary to make our mosaic plot, you can wrap all the steps into a single function that we can use to examine any two variables of interest in our data frame (or in any other data frame for that matter). For example, we can use it to examine the Vocab data frame we saw earlier in this course.

You've seen all the code in our function, so there shouldn't be anything surprising there. Notice that the function takes multiple arguments, such as the data frame of interest and the variables that you want to create the mosaic plot for. None of the arguments have default values, so you'll have to specify all three if you want the mosaicGG() function to work.

Start by going through the code and see if you understand the function's implementation.

Instructions
Calling mosaicGG(adult, "SRAGE_P","RBMI") will result in the plot you've been working on so far. Try this out. This gives you a mosaic plot where BMI is described by age.
Test out another combination of variables in the adult data frame: Poverty (POVLL) described by Age (SRAGE_P).
Try the function on other datasets we've worked with throughout this course:
mtcars dataset: am described by cyl
Vocab dataset: vocabulary described by education.

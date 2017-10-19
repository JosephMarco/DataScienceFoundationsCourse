suppressMessages(library(tidyverse))
suppressMessages(library(ggplot2))
setwd("~/DataScienceFoundationsCourse/MachineLearning/LogisticRegression")



#### Use the NH11 data set that we loaded earlier.


health <- readRDS("NatHealth2011.rds")

#inspect the structure of the data set
str(health)


#### Use glm to conduct a logistic regression to predict ever worked (everwrk) using age (age_p) and marital status (r_maritl).

#Check the structure and levels of the everwrk field value
str(health$everwrk) # check stucture of hypev
# check levels of hypev

#clean values that are missing to NA
health$everwrk <- factor(health$everwrk, levels=c("2 No", "1 Yes"))

#confirm values are now cleansed to be jus tyes or no
levels(health$everwrk)



# Run the regression model, using the above mentioned values (age and marital status)
wrkmodel <- glm(everwrk~r_maritl,
               data=health, family="binomial")

coef(summary(wrkmodel))

# For example, what we can see with the above coefficient summary is the fact that for marital status' like Divorced, and Living with partner, we have a high coefficient, meaning ever work log odds increase by .73 and .44 respectively. Meaning if you are divorced or living with a partner, you are likely working! Where as something like "Widowed" the ever work log odds would decrease by .68 showing a low probability of working if you are widowed.



# Since most of us are not used to thinking in log odds this is not too helpful. One solution is to transform the coefficients to make them easier to interpret:

wrkmodel.tab <- coef(summary(wrkmodel))
wrkmodel.tab[, "Estimate"] <- exp(coef(wrkmodel))
wrkmodel.tab


# predict hypertension at those levels
predDat <- with(health,
                expand.grid(r_maritl = unique(r_maritl)))

cbind(predDat, predict(wrkmodel, type = "response",
                       se.fit = TRUE, interval="confidence",
                       newdata = predDat))

old.par.settings <- par(cex.lab=1)
par(old.par.settings)

library(effects)
plot(allEffects(wrkmodel), cex.lab = .2) #rank them in the graph, make sure labels dont overlap, small font or recode


#suppressmessages so we do not get a ton of additional run on loading criteria
suppressMessages(library(tidyverse))

#assign data to a dataframe, in this case "capstonedata"
setwd("~/DataScienceFoundationsCourse/Capstone")

capstonedata <- read.csv('productbackorder.csv')

# you can view your datafram with the code below if you are interested in initial analysis
# View(capstonedata)

capstonedata <- rename(capstonedata, min_stock = min_bank)

any(is.na(capstonedata$sku))
any(is.na(capstonedata$national_inv))
any(is.na(capstonedata$lead_time))
any(is.na(capstonedata$in_transit_qty))
any(is.na(capstonedata$forecast_3_month))
any(is.na(capstonedata$forecast_6_month))
any(is.na(capstonedata$forecast_9_month))
any(is.na(capstonedata$sales_1_month))
any(is.na(capstonedata$sales_3_month))
any(is.na(capstonedata$sales_6_month))
any(is.na(capstonedata$sales_9_month))
any(is.na(capstonedata$min_stock))
any(is.na(capstonedata$potential_issue))
any(is.na(capstonedata$pieces_past_due))
any(is.na(capstonedata$perf_6_month_avg))
any(is.na(capstonedata$perf_12_month_avg))
any(is.na(capstonedata$local_bo_qty))
any(is.na(capstonedata$deck_risk))
any(is.na(capstonedata$oe_constraint))
any(is.na(capstonedata$ppap_risk))
any(is.na(capstonedata$stop_auto_buy))
any(is.na(capstonedata$rev_stop))
any(is.na(capstonedata$went_on_backorder))


#replace null
national_inv_mean <- mean(capstonedata$national_inv[!is.na(capstonedata$national_inv)])
lead_time_mean <- mean(capstonedata$lead_time[!is.na(capstonedata$lead_time)])
in_transit_qty_mean <- mean(capstonedata$in_transit_qty[!is.na(capstonedata$in_transit_qty)])
forecast_3_month_mean <- mean(capstonedata$forecast_3_month[!is.na(capstonedata$forecast_3_month)])
forecast_6_month_mean <- mean(capstonedata$forecast_6_month[!is.na(capstonedata$forecast_6_month)])
forecast_9_month_mean <- mean(capstonedata$forecast_9_month[!is.na(capstonedata$forecast_9_month)])
sales_1_month_mean <- mean(capstonedata$sales_1_month[!is.na(capstonedata$sales_1_month)])
sales_3_month_mean <- mean(capstonedata$sales_3_month[!is.na(capstonedata$sales_3_month)])
sales_6_month_mean <- mean(capstonedata$sales_6_month[!is.na(capstonedata$sales_6_month)])
sales_9_month_mean <- mean(capstonedata$sales_9_month[!is.na(capstonedata$sales_9_month)])
min_stock_mean <- mean(capstonedata$min_stock[!is.na(capstonedata$min_stock)])
pieces_past_due_mean <- mean(capstonedata$pieces_past_due[!is.na(capstonedata$pieces_past_due)])
perf_6_month_avg_mean <- mean(capstonedata$perf_6_month_avg[!is.na(capstonedata$perf_6_month_avg)])
perf_12_month_avg_mean <- mean(capstonedata$perf_12_month_avg[!is.na(capstonedata$perf_12_month_avg)])
local_bo_qty_mean <- mean(capstonedata$local_bo_qty[!is.na(capstonedata$local_bo_qty)])

write.csv(capstonedata, file = "capstonedata_clean.csv")


#read in cleansed file
capstonedata3 <- read.csv('capstonedata_clean.csv')

#double check for nulls
any(is.na(capstonedata3))

#replace yes/no for binary values
indx = sapply(capstonedata,is.factor)
capstonedata3[indx]= lapply(capstonedata3[indx],as.character)
capstonedata3[capstonedata3 == "Yes"] = 1
capstonedata3[capstonedata3 == "No"] = 0
capstonedata3[indx]= lapply(capstonedata3[indx],as.numeric)

#lets check the structure now, we should see no more yes or no values
str(capstonedata3)

#load libraries
library(caret)
library(caTools)

#set seed
set.seed(150)

#split dataset
split = sample.split(capstonedata3$went_on_backorder, SplitRatio = .7)
split

#create train and test set
BackorderTrain = subset(capstonedata3), split == TRUE))
BackorderTest = subset(capstonedata3), split == FALSE))

#check rows of each
nrow(BackorderTrain)
nrow(BackorderTest)

#double check no NAs
any(is.na(BackorderTrain))

BackorderTrain <- na.omit(BackorderTrain)

any(is.na(BackorderTrain))

Backorderlog <- glm(went_on_backorder ~ lead_time + national_inv, data = BackorderTrain, family = binomial)

summary(Backorderlog)

predictTrain <- predict(Backorderlog, type = "response")
summary(predictTrain)

nrow(BackorderTrain)
length(predictTrain)

tapply(predictTrain, BackorderTrain$went_on_backorder, mean)



#calculate sensitivity
3/7656

#Calculate specificity
1103232/1103263

#accuracy
1103248/1110919

library(ROCR)

ROCRpred <- prediction(predictTrain, BackorderTrain$went_on_backorder)

ROCRperf <- performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf)
plot(ROCRperf, colorize = TRUE)
plot(ROCRperf, colorize = TRUE, print.cutoffs.at=seq(0,1,0.1), text.adj=c(-0.2, 1.7))




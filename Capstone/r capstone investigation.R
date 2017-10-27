setwd("~/DataScienceFoundationsCourse/Capstone")

capstonedata <- read.csv('capstonedata_clean.csv')

any(is.na(capstonedata$sku))

nrow(distinct(capstonedata)) 

table(capstonedata$went_on_backorder)

any(is.na(capstonedata))

indx = sapply(capstonedata,is.factor)
capstonedata[indx]= lapply(capstonedata[indx],as.character)
capstonedata[capstonedata == "Yes"] = 1
capstonedata[capstonedata == "No"] = 0
capstonedata[indx]= lapply(capstonedata[indx],as.numeric)

str(capstonedata)

library(caret)
library(caTools)

set.seed(150)

split = sample.split(capstonedata$went_on_backorder, SplitRatio = .7)
table(split)

#Define train and test sets
BackorderTrain = subset(capstonedata, split == TRUE)
BackorderTest = subset(capstonedata, split == FALSE)

#eliminate NAs from train set
BackorderTrain <- na.omit(BackorderTrain)

#count rows of train and test 
nrow(BackorderTrain)
nrow(BackorderTest)

#use glm function
Backorderlog <- glm(went_on_backorder ~ lead_time + national_inv , data = BackorderTrain, family = binomial)

#view summary of glm function
summary(Backorderlog)

#make predictions
predictTrain <- predict(Backorderlog, type = "response")
summary(predictTrain)

tapply(predictTrain, BackorderTrain$went_on_backorder, mean)

table(BackorderTrain$went_on_backorder, predictTrain > .2)

library(ROCR)

ROCRpred <- prediction(predictTrain, BackorderTrain$went_on_backorder)
ROCRperf <- performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf, colorize = TRUE, main = "ROC Curve", ylab = "Sensitivity (True positive rate)", xlab = "1-Sensitivity (False positive rate)")
abline(a=0, b=1)

auc <-performance(ROCRpred, "auc")

auc <- unlist(slot(auc, "y.values"))

auc

auc <- round(auc, 4)

legend(.6, .2, auc, title = "AUC")

model_more_predictors <- glm(went_on_backorder ~ lead_time + national_inv + forecast_3_month + sales_9_month, data = BackorderTrain, family = binomial)

library(lmtest)
anova(model_more_predictors, Backorderlog, test = "LRT")

#overall Accuracy
1173561/1181502

#Overall Error Rate
7941/1181502

#calculate sensitivity
3/7905
#Calculate specificity
1173558/1173597

predictTest <- predict(Backorderlog, type="response", newdata = BackorderTest)
summary(predictTest)

tapply(predictTest, BackorderTest$went_on_backorder, mean)

table(BackorderTest$went_on_backorder, predictTest > .2)

502955/506358

library(randomForest)
library(randomForestSRC)
library(randomForestExplainer)

set.seed(2017)
#training Sample with 300 observations
train=sample(1:nrow(capstonedata),300)

capstone.rf <- randomForest(sku ~ . , data = capstonedata , subset = train)

capstone.rf

min_depth_frame <- min_depth_distribution(capstone.rf)

head(min_depth_frame, n = 10)

plot_min_depth_distribution(min_depth_frame)

plot_min_depth_distribution(min_depth_frame, mean_sample = "relevant_trees", k = 15)

importance_frame <- measure_importance(capstone.rf)

importance_frame

plot_multi_way_importance(importance_frame, size_measure = "no_of_nodes")

plot(capstone.rf)

plot_importance_ggpairs(importance_frame)

plot_importance_rankings(importance_frame)

plot_predict_interaction(capstone.rf, capstonedata, "rm", "lstat")

explain_forest(capstone.rf, interactions = TRUE, data = capstonedata)

min_dept




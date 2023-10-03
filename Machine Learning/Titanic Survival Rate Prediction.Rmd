# Titanic Survival Rate Prediction

## 1. Load Library
-- by using 'caret' for classification and regression training

library(titanic) # Dataset
library(caret)

-- and checking the Titanic dataset

head(titanic_train)
nrow(titanic_train)
str(titanic_train)

## 2. Clean Data
-- by dropping NULL (NA values)

titanic_train <- na.omit(titanic_train)

## 3. Split Data
-- into 2 sets: train & test data

set.seed(08)
n <- nrow(titanic_train)
id <- sample(1:n, size=n*0.7) # 70 train 30 test
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

## 4. Train Model

logis_model <- glm(Survived ~ Pclass + Age, 
                   data = train_data, 
                   family = "binomial")
summary(logis_model)

#### 4.1. Probability
-- Test Model

p_test <- predict(logis_model, 
                  newdata = test_data, 
                  type = "response")
test_data$pred <- ifelse(p_test >= 0.6, 1, 0)

-- Train Model

p_train <- predict(logis_model,
                   type = "response")

train_data$pred <- ifelse(p_train >= 0.6, 1, 0)

#### 4.2. Confusion Matrix

con_train <- table(train_data$pred,
                   train_data$Survived,
                   dnn = c("Predicted", "Actual")) # Train
con_train

con_test <- table(test_data$pred,
                  test_data$Survived,
                  dnn = c("Predicted", "Actual")) # Test
con_test

trainAcc <- (con_train[1,1] + con_train[2,2])/sum(con_train)
trainPre <- con_train[2,2]/(con_train[2,1] + con_train[2,2])
trainRec <- con_train[2,2]/(con_train[1,2] + con_train[2,2])
trainF1 <- 2*((trainPre*trainRec)/(trainPre+trainRec))
cat("Train Model Evaluation",
    "\nAccuracy", trainAcc,
    "\nPrecision", trainPre,
    "\nRecall", trainRec,
    "\nF1", trainF1)

testAcc <- (con_test[1,1] + con_test[2,2])/sum(con_test)
testPre <- con_test[2,2]/(con_test[2,1] + con_test[2,2])
testRec <- con_test[2,2]/(con_test[1,2] + con_test[2,2])
testF1 <- 2*((testPre*testRec)/(testPre+testRec))
cat("Test Model Evaluation",
    "\nAccuracy", testAcc,
    "\nPrecision", testPre,
    "\nRecall", testRec,
    "\nF1", testF1)

## 5. Evaluate Model

train_check <- mean(train_data$Survived == train_data$pred)
test_check <- mean(test_data$Survived == test_data$pred)

## recap ML workflow (simple)

## 1. split data
## 2. train model
## 3. score (predict test data)
## 4. evaluate model (train error vs. test error)

## the biggest problem = overfitting
## optimization vs. machine lernning

library(tidyverse)
library(caret)
library(mlbench)

## split
split_data <- function(data){
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, size=0.7*n)
  train_df <- data[id, ]
  test_df <- data[-id, ]
  return ( list(train=train_df,
                test=test_df))
}

prep_df <- split_data(mtcars)

## k-fold cross validation

set.seed(42)

grid_k <- data.frame(k = c(5,7))

## repeated k-fold cv

ctrl <- trainControl(method = "repeatedcv",
                     number = 5,
                     repeats = 5,
                      verboseIter = TRUE) #k

knn <- train(mpg ~ ., 
             data = prep_df$train,
             method = "knn",
             metric = "MAE",
             trControl = ctrl,
             tuneLength = 4)



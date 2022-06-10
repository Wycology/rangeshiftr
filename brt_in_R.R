# Boosted regression trees in R

library(MASS) # Library with the data to work on
data("Boston")
library(gbm) # Library for building the model

# Boosted regression tree

model <- gbm(medv ~., data = Boston)
model

# Random forest
library(caret)
set.seed(1)

model <- train(medv ~., data = Boston, method = "rf", verbose = FALSE)

model

plot(model)

set.seed(1)

model2 <- train(medv ~., data = Boston, method = "gbm", 
                preProcess = c("center", "scale"), verbose = FALSE)
model2

#  Preprocessing with caret
# Splitting the dataset

set.seed(1)

in_training <- createDataPartition(Boston$medv, p = .80, list = FALSE)
training <- Boston[in_training,]
testing <- Boston[-in_training, ]

set.seed(1)

model3 <- train(medv ~., data = training, method = "gbm", 
                preProcess = c("center", "scale"), verbose = FALSE)

model3

test_features <- subset(testing, select = -c(medv))
test_target <- subset(testing, select = medv)[,1]

predictions <- predict(model3, newdata = test_features)

# RMSE

sqrt(mean((test_target - predictions)^2))

# r2

cor(test_target, predictions)^2

# Cross-validation

set.seed(1)

ctrl <- trainControl(method = "cv", number = 10)

set.seed(1)

model4 <- train(medv ~., data = training, method = "gbm", 
                preProcess = c("center", "scale"), trControl = ctrl, verbose = FALSE)


model4
plot(model4)


test_features <- subset(testing, select = -c(medv))
test_target <- subset(testing, select = medv)[, 1]

predictions <- predict(model4, newdata = test_features)

# RMSE 
sqrt(mean((test_target - predictions)^2))

# R2

cor(test_target, predictions) ^2

set.seed(1)

tune_grid <- expand.grid(n.trees = c(50, 100), interaction.depth = c(1, 2), 
                         shrinkage = 0.1, n.minobsinnode = 10)

model5 <- train(medv ~., data = Boston, method = "gbm", preProcess = c("center", "scale"),
                trControl = ctrl, tuneGrid = tune_grid, verbose = FALSE)
model5

plot(model5)
















# Boosted regression trees in R

library(MASS) # Library with the data to work on
data("Boston")
library(gbm) # Library for building the model

model <- gbm(medv ~., data = Boston)
model

library(caret)
set.seed(1)

model <- train(medv ~., data = Boston, method = "gbm", verbose = FALSE)

model

plot(model)

set.seed(1)

model2 <- train(medv ~., data = Boston, method = "gbm", 
                preProcess = c("center", "scale"), verbose = FALSE)
model2


















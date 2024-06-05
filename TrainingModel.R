# Load dataset
crab_data <- read.csv("data/CrabAgePrediction.csv", colClasses = c(
  Sex = "factor",
  Length = "numeric",
  Diameter = "numeric",
  Height = "numeric",
  Weight = "numeric",
  Shucked_Weight = "numeric",
  Viscera_Weight = "numeric",
  Shell_Weight = "numeric",
  Age = "integer"
))

# Display the structure of the dataset
str(crab_data)

# View the first few rows of the dataset
head(crab_data)

# View the dataset in a separate viewer window
View(crab_data)

# Load necessary libraries
library(caret)
library(dplyr)

# Split the data into training (80%) and test (20%) sets
set.seed(123)
trainIndex <- createDataPartition(crab_data$Age, p = 0.8, list = FALSE)
train_data <- crab_data[trainIndex,]
test_data <- crab_data[-trainIndex,]

# Display the size of training and test sets
cat("Training set size:", nrow(train_data), "\n")
cat("Test set size:", nrow(test_data), "\n")

# Load necessary libraries
library(boot)

# Define a function to calculate the mean of Weight
mean_weight <- function(data, indices) {
  sample_data <- data[indices, ]
  return(mean(sample_data$Weight))
}

# Perform bootstrapping
set.seed(123)
boot_results <- boot(data = crab_data, statistic = mean_weight, R = 1000)

# Display bootstrapping results
print(boot_results)

# Plot the bootstrapping results
plot(boot_results)

# Load necessary libraries
library(caret)

# Define a control function for k-fold cross-validation
control <- trainControl(method = "cv", number = 10)

# Train a linear regression model using k-fold cross-validation
set.seed(123)
cv_model <- train(Age ~ Length + Diameter + Height + Weight + Shucked_Weight + Viscera_Weight + Shell_Weight,
                  data = train_data,
                  method = "lm",
                  trControl = control)

# Display the cross-validation results
print(cv_model)

# Predict on the test set
predictions <- predict(cv_model, newdata = test_data)

# Calculate and display performance metrics
mse <- mean((predictions - test_data$Age)^2)
rmse <- sqrt(mse)
cat("Mean Squared Error:", mse, "\n")
cat("Root Mean Squared Error:", rmse, "\n")

# Load necessary libraries
library(caret)
library(rpart)
library(randomForest)

# Train a linear regression model
lm_model <- train(Age ~ Length + Diameter + Height + Weight + Shucked_Weight + Viscera_Weight + Shell_Weight,
                  data = train_data,
                  method = "lm")

# Display the linear regression model summary
print(summary(lm_model$finalModel))

# Predict on the test set
lm_predictions <- predict(lm_model, newdata = test_data)

# Calculate performance metrics
lm_mse <- mean((lm_predictions - test_data$Age)^2)
lm_rmse <- sqrt(lm_mse)
cat("Linear Regression - Mean Squared Error:", lm_mse, "\n")
cat("Linear Regression - Root Mean Squared Error:", lm_rmse, "\n")

# Train a decision tree model
dt_model <- train(Age ~ Length + Diameter + Height + Weight + Shucked_Weight + Viscera_Weight + Shell_Weight,
                  data = train_data,
                  method = "rpart")

# Display the decision tree model summary
print(dt_model$finalModel)

# Plot the decision tree
plot(dt_model$finalModel)
text(dt_model$finalModel, use.n = TRUE)

# Predict on the test set
dt_predictions <- predict(dt_model, newdata = test_data)

# Calculate performance metrics
dt_mse <- mean((dt_predictions - test_data$Age)^2)
dt_rmse <- sqrt(dt_mse)
cat("Decision Tree - Mean Squared Error:", dt_mse, "\n")
cat("Decision Tree - Root Mean Squared Error:", dt_rmse, "\n")

# Train a random forest model
set.seed(123)
rf_model <- randomForest(Age ~ Length + Diameter + Height + Weight + Shucked_Weight + Viscera_Weight + Shell_Weight,
                         data = train_data, ntree = 500)

# Display the random forest model summary
print(rf_model)

# Predict on the test set
rf_predictions <- predict(rf_model, newdata = test_data)

# Calculate performance metrics
rf_mse <- mean((rf_predictions - test_data$Age)^2)
rf_rmse <- sqrt(rf_mse)
cat("Random Forest - Mean Squared Error:", rf_mse, "\n")
cat("Random Forest - Root Mean Squared Error:", rf_rmse, "\n")

# Load necessary libraries
library(caret)
library(dplyr)
library(reshape2)

# Define training control
train_control <- trainControl(method = "cv", number = 10)

# Define models
models <- list(
  "Linear Regression" = list(model = "lm", method = "lm"),
  "Decision Tree" = list(model = "rpart", method = "rpart"),
  "Random Forest" = list(model = "rf", method = "rf")
)

# Train and evaluate models
results <- lapply(models, function(model) {
  set.seed(123)
  train(Age ~ Length + Diameter + Height + Weight + Shucked_Weight + Viscera_Weight + Shell_Weight,
        data = crab_data,
        method = model$method,
        trControl = train_control)
})

# Extract performance metrics
performance <- lapply(results, function(model) {
  resamples <- model$resample
  resamples$Model <- rownames(resamples)
  return(resamples)
})

# Combine results into a single data frame
performance_df <- do.call(rbind, performance)

# Reshape data for visualization
performance_melted <- melt(performance_df, id.vars = "Model", variable.name = "Metric", value.name = "Value")

# Plot model performance
ggplot(performance_melted, aes(x = Model, y = Value, fill = Model)) +
  geom_boxplot() +
  facet_wrap(~ Metric, scales = "free_y") +
  labs(title = "Model Performance Comparison", y = "Value")
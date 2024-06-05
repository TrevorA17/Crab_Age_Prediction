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

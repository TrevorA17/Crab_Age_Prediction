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

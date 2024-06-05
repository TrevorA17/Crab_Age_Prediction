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

# Check for missing values in each column
missing_values <- sapply(crab_data, function(x) sum(is.na(x)))
print(missing_values)

# Display the columns with missing values and their counts
missing_values_df <- data.frame(Column = names(missing_values), MissingValues = missing_values)
print(missing_values_df)

# Visualize missing values using the VIM package
install.packages("VIM") # Uncomment if not installed
library(VIM)
aggr(crab_data, col = c('navyblue', 'red'), numbers = TRUE, sortVars = TRUE, labels = names(crab_data), cex.axis = 0.7, gap = 3, ylab = c("Missing data", "Pattern"))
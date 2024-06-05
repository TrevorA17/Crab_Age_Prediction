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
library(ggplot2)

# Frequency distribution of categorical variable 'Sex'
sex_frequency <- table(crab_data$Sex)
print(sex_frequency)

# Plot frequency distribution of 'Sex'
ggplot(crab_data, aes(x = Sex)) + 
  geom_bar(fill = "lightblue", color = "black") +
  labs(title = "Frequency Distribution of Sex", x = "Sex", y = "Frequency")


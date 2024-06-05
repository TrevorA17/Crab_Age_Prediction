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

# Mean of numeric variables
mean_length <- mean(crab_data$Length, na.rm = TRUE)
mean_diameter <- mean(crab_data$Diameter, na.rm = TRUE)
mean_height <- mean(crab_data$Height, na.rm = TRUE)
mean_weight <- mean(crab_data$Weight, na.rm = TRUE)
mean_shucked_weight <- mean(crab_data$Shucked_Weight, na.rm = TRUE)
mean_viscera_weight <- mean(crab_data$Viscera_Weight, na.rm = TRUE)
mean_shell_weight <- mean(crab_data$Shell_Weight, na.rm = TRUE)
mean_age <- mean(crab_data$Age, na.rm = TRUE)

print(c(mean_length, mean_diameter, mean_height, mean_weight, mean_shucked_weight, mean_viscera_weight, mean_shell_weight, mean_age))

# Median of numeric variables
median_length <- median(crab_data$Length, na.rm = TRUE)
median_diameter <- median(crab_data$Diameter, na.rm = TRUE)
median_height <- median(crab_data$Height, na.rm = TRUE)
median_weight <- median(crab_data$Weight, na.rm = TRUE)
median_shucked_weight <- median(crab_data$Shucked_Weight, na.rm = TRUE)
median_viscera_weight <- median(crab_data$Viscera_Weight, na.rm = TRUE)
median_shell_weight <- median(crab_data$Shell_Weight, na.rm = TRUE)
median_age <- median(crab_data$Age, na.rm = TRUE)

print(c(median_length, median_diameter, median_height, median_weight, median_shucked_weight, median_viscera_weight, median_shell_weight, median_age))

# Standard deviation of numeric variables
sd_length <- sd(crab_data$Length, na.rm = TRUE)
sd_diameter <- sd(crab_data$Diameter, na.rm = TRUE)
sd_height <- sd(crab_data$Height, na.rm = TRUE)
sd_weight <- sd(crab_data$Weight, na.rm = TRUE)
sd_shucked_weight <- sd(crab_data$Shucked_Weight, na.rm = TRUE)
sd_viscera_weight <- sd(crab_data$Viscera_Weight, na.rm = TRUE)
sd_shell_weight <- sd(crab_data$Shell_Weight, na.rm = TRUE)
sd_age <- sd(crab_data$Age, na.rm = TRUE)

print(c(sd_length, sd_diameter, sd_height, sd_weight, sd_shucked_weight, sd_viscera_weight, sd_shell_weight, sd_age))

# Plot distribution of 'Length'
ggplot(crab_data, aes(x = Length)) + 
  geom_histogram(binwidth = 0.1, fill = "lightgreen", color = "black") +
  labs(title = "Distribution of Length", x = "Length", y = "Frequency")

# Correlation matrix of numeric variables
cor_matrix <- cor(crab_data[, c("Length", "Diameter", "Height", "Weight", "Shucked_Weight", "Viscera_Weight", "Shell_Weight", "Age")], use = "complete.obs")
print(cor_matrix)

# Plot correlation matrix
library(corrplot)
corrplot(cor_matrix, method = "circle")

# Scatter plot of Length vs Age
ggplot(crab_data, aes(x = Length, y = Age)) + 
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Length vs Age", x = "Length", y = "Age")

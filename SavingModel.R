# Saving the linear regression model
saveRDS(lm_model, "./models/saved_lm_model.rds")

# Load the saved model
loaded_lm_model <- readRDS("./models/saved_lm_model.rds")

# Prepare new data for prediction
new_data <- data.frame(
  Length = 1.5,
  Diameter = 1.2,
  Height = 0.4,
  Weight = 30,
  Shucked_Weight = 15,
  Viscera_Weight = 7,
  Shell_Weight = 8
)

# Use the loaded model to make predictions
predictions_loaded_model <- predict(loaded_lm_model, newdata = new_data)

# Print predictions
print(predictions_loaded_model)

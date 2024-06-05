# Load the saved linear regression model
loaded_lm_model <- readRDS("./models/saved_lm_model.rds")

#* @apiTitle Crab Age Prediction Model API
#* @apiDescription Used to predict the age of crabs.

#* @param Length Length of the crab
#* @param Diameter Diameter of the crab
#* @param Height Height of the crab
#* @param Weight Weight of the crab
#* @param Shucked_Weight Weight of the shucked part of the crab
#* @param Viscera_Weight Weight of the viscera part of the crab
#* @param Shell_Weight Weight of the shell of the crab

#* @get /crab_age_prediction

predict_crab_age <- function(Length, Diameter, Height, Weight, Shucked_Weight, Viscera_Weight, Shell_Weight) {
  
  # Create a data frame using the arguments
  to_be_predicted <- data.frame(
    Length = as.numeric(Length),
    Diameter = as.numeric(Diameter),
    Height = as.numeric(Height),
    Weight = as.numeric(Weight),
    Shucked_Weight = as.numeric(Shucked_Weight),
    Viscera_Weight = as.numeric(Viscera_Weight),
    Shell_Weight = as.numeric(Shell_Weight)
  )
  
  # Use the loaded model to make predictions
  prediction <- predict(loaded_lm_model, newdata = to_be_predicted)
  
  # Return the prediction
  return(prediction)
}

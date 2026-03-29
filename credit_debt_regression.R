# =============================================================================
# Credit Card Debt Prediction: Multiple Linear Regression Analysis
# =============================================================================

# Load Required Libraries -------------------------------------------------
library(ISLR2)      # For Credit dataset
library(car)        # For VIF and diagnostic functions

# Load and Explore Data ---------------------------------------------------

# Load Credit dataset
data(Credit)

# Initial data exploration
head(Credit)
str(Credit)
summary(Credit)

# =============================================================================
# MODEL BUILDING
# =============================================================================

# Full Model: All Available Predictors -----------------------------------
# Initial model including all potential predictor variables
model_full <- lm(Balance ~ Income + Limit + Rating + Cards + Age + 
                   Education + Own + Student + Married + Region, 
                 data = Credit)

summary(model_full)

# Reduced Model: Selected Significant Variables --------------------------
# Model with statistically significant and theoretically important predictors
model_selected <- lm(Balance ~ Income + Limit + Rating + Cards + Age + Student, 
                     data = Credit)

summary(model_selected)

# =============================================================================
# MODEL DIAGNOSTICS
# =============================================================================

# 1. Multicollinearity Check ----------------------------------------------
# Using Variance Inflation Factor (VIF)
# Rule: VIF > 10 indicates problematic multicollinearity
vif_values <- vif(model_selected)
print("Variance Inflation Factors:")
print(vif_values)

# 2. Linearity Assumption -------------------------------------------------
# Check for linear relationship between predictors and residuals
# Residual plots should show random scatter around zero

par(mfrow = c(2, 3))  # Create 2x3 grid of plots

plot(Credit$Income, model_selected$residuals, 
     main = "Residuals vs Income", 
     xlab = "Income", 
     ylab = "Residuals")
abline(h = 0, col = "red", lty = 2)

plot(Credit$Limit, model_selected$residuals, 
     main = "Residuals vs Limit", 
     xlab = "Credit Limit", 
     ylab = "Residuals")
abline(h = 0, col = "red", lty = 2)

plot(Credit$Rating, model_selected$residuals, 
     main = "Residuals vs Rating", 
     xlab = "Credit Rating", 
     ylab = "Residuals")
abline(h = 0, col = "red", lty = 2)

plot(Credit$Cards, model_selected$residuals, 
     main = "Residuals vs Cards", 
     xlab = "Number of Cards", 
     ylab = "Residuals")
abline(h = 0, col = "red", lty = 2)

plot(Credit$Age, model_selected$residuals, 
     main = "Residuals vs Age", 
     xlab = "Age", 
     ylab = "Residuals")
abline(h = 0, col = "red", lty = 2)

plot(Credit$Student, model_selected$residuals, 
     main = "Residuals vs Student Status", 
     xlab = "Student (Yes/No)", 
     ylab = "Residuals")
abline(h = 0, col = "red", lty = 2)

par(mfrow = c(1, 1))  # Reset plot layout

# 3. Homoscedasticity (Equal Variance) Check ------------------------------
# Residuals should have constant variance across fitted values
par(mfrow = c(2, 2))
plot(model_selected)
par(mfrow = c(1, 1))

# 4. Normality of Residuals -----------------------------------------------
# Q-Q plot should show residuals following normal distribution
residuals <- model_selected$residuals

qqnorm(residuals, main = "Normal Q-Q Plot of Residuals")
qqline(residuals, col = "red")

# 5. Outlier Detection ----------------------------------------------------
# Standardized residuals beyond ±2 may indicate outliers
std_residuals <- rstandard(model_selected)

plot(std_residuals, 
     main = "Standardized Residuals", 
     xlab = "Observation Index", 
     ylab = "Standardized Residuals")
abline(h = c(-2, 2), col = "red", lty = 2)
abline(h = 0, col = "blue", lty = 2)

# Identify potential outliers
outliers <- which(abs(std_residuals) > 2)
if(length(outliers) > 0) {
  cat("\nPotential outliers at observations:", outliers, "\n")
}

# 6. Influential Observations ---------------------------------------------
# High leverage points that may disproportionately affect the model
leverage <- hatvalues(model_selected)

plot(leverage, 
     main = "Leverage Values", 
     xlab = "Observation Index", 
     ylab = "Leverage")
abline(h = 2 * mean(leverage), col = "red", lty = 2)

# Identify high leverage points
high_leverage <- which(leverage > 2 * mean(leverage))
if(length(high_leverage) > 0) {
  cat("\nHigh leverage observations:", high_leverage, "\n")
}

# =============================================================================
# FINAL MODEL SELECTION AND ANALYSIS
# =============================================================================

# Further Reduced Model: Most Significant Predictors ---------------------
# Remove variables with high multicollinearity (Limit likely correlates with Rating)
model_final <- lm(Balance ~ Income + Rating + Age + Student, 
                  data = Credit)

summary(model_final)

# ANOVA: Test Overall Model Significance ----------------------------------
anova_results <- anova(model_final)
print("ANOVA Results:")
print(anova_results)

# Confidence Intervals for Coefficients -----------------------------------
# 95% confidence intervals for regression coefficients
ci_results <- confint(model_final)
print("95% Confidence Intervals for Coefficients:")
print(ci_results)

# =============================================================================
# MODEL INTERPRETATION SUMMARY
# =============================================================================

cat("\n=== FINAL MODEL SUMMARY ===\n")
cat("Predictors: Income, Rating, Age, Student Status\n")
cat("R-squared:", summary(model_final)$r.squared, "\n")
cat("Adjusted R-squared:", summary(model_final)$adj.r.squared, "\n")
cat("F-statistic p-value:", 
    pf(summary(model_final)$fstatistic[1], 
       summary(model_final)$fstatistic[2], 
       summary(model_final)$fstatistic[3], 
       lower.tail = FALSE), "\n")

# =============================================================================
# END OF ANALYSIS
# =============================================================================

# credit-card-debt-regression
Multiple linear regression analysis identifying key factors that predict credit card balance using the ISLR2 Credit dataset.

## Overview

This project builds and validates a predictive model for credit card debt, examining relationships between demographic factors, credit characteristics, and outstanding balance.

## Key Findings

- **Significant Predictors:** Credit rating, income, student status, and age significantly predict credit card balance
- **Student Effect:** Student status showed strong positive relationship with debt levels
- **Credit Rating Impact:** Higher credit ratings associated with higher balances (likely due to higher credit limits)
- **Model Performance:** Achieved R² = 0.9504, explaining substantial variance in credit card debt
- **Multicollinearity:** Removed credit limit variable due to high correlation with credit rating (VIF > 10)

## Tools & Technologies

- **R** (tidyverse, ISLR2, car)
- Multiple Linear Regression
- Model Diagnostics (VIF, residual analysis, leverage)
- ANOVA
- Statistical Inference

## Dataset

**Source:** ISLR2 package - Credit dataset  
**Observations:** 400 customers  
**Variables:**
- **Response:** Balance (credit card debt)
- **Predictors:** Income, credit limit, credit rating, number of cards, age, education, homeownership, student status, marital status, region

## Analysis Workflow

1. **Exploratory Data Analysis** - Examine distributions and relationships
2. **Full Model** - Test all available predictors
3. **Model Selection** - Remove non-significant variables
4. **Diagnostic Testing:**
   - Multicollinearity (VIF)
   - Linearity (residual plots)
   - Homoscedasticity (equal variance)
   - Normality of residuals (Q-Q plots)
   - Outlier detection (standardized residuals)
   - Influential observations (leverage analysis)
5. **Final Model** - Reduced model with significant predictors
6. **Statistical Inference** - ANOVA and confidence intervals

## Key Statistical Tests

- **Variance Inflation Factor (VIF):** Assessed multicollinearity
- **Residual Analysis:** Validated model assumptions
- **ANOVA:** Tested overall model significance
- **Confidence Intervals:** Estimated parameter uncertainty

## Model Equation

Final Model:
```
Balance = β₀ + β₁(Income) + β₂(Rating) + β₃(Age) + β₄(Student) + ε
```

## How to Run

1. **Install required packages:**
```r
install.packages("ISLR2")
install.packages("car")
```

2. **Run the analysis:**
```r
source("credit_debt_regression.R")
```

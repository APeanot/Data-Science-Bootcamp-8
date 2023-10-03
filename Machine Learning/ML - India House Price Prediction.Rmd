library(tidyverse)
library(caret)
library(ggplot2)
library(readxl)

df2016 <- read_excel("India House Price/House Price India.xlsx", sheet = 1)
df2017 <- read_excel("India House Price/House Price India.xlsx", sheet = 2)
full_df <- bind_rows(df2016, df2017)

ggplot(data = full_df, aes(Price)) +
  geom_histogram(bins = 100,
                 fill = "Blue",
                 alpha = 0.6) +
  theme_minimal() +
  labs(title = "Distribution",
       x = "Price",
       y = "Count")

full_df$log_price <- log(full_df$Price)

ggplot(data = full_df, aes(log_price)) +
  geom_histogram(bins = 100,
                 fill = "Blue",
                 alpha = 0.6) +
  theme_minimal() +
  labs(title = "Distribution",
       x = "Price",
       y = "Count")

full_full_df <- full_df %>%
  select('number of bedrooms',
         'number of bathrooms',
         'living area',
         'lot area',
         'grade of the house',
         'log_price')

full_full_df %>%
  complete.cases() %>%
  mean()

set.seed(08)
n <- nrow(full_full_df)
train_id <- sample(1:n, 0.8*n)
train_df <- full_full_df[train_id, ]
test_df <- full_full_df[-train_id, ]

set.seed(80)
ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE
)

model <- train(log_price ~ .,
               data = train_df,
               method = "glmnet",
               trControl = ctrl)

p <- predict(model, newdata = test_df)

abs_matrix <- function(actual, pred) {
  cal_mae <- mean(abs(actual - pred))
  cal_mse <- mean((actual - pred)**2)
  cal_rmse <- sqrt(mean((actual - pred)**2))
  list(mae = cal_mae, mse = cal_mse, rmse = cal_rmse)
}

test <- abs_matrix(test_df$log_price, p)

test

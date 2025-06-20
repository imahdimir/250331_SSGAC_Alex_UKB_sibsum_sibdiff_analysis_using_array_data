#!/usr/bin/env Rscript

## ---------------------------------------------------------------------
## description:
## ---------------------------------------------------------------------


##  ---------------------------------------------------------------------
## packages

# Try to load pacman using require(), If it's not found, installs it from CRAN
if (!require("pacman")) install.packages("pacman")
library("pacman")

# Installs any missing packages and loads them
pacman::p_load(readr, ggplot2, dplyr, glue, arrow, broom)

## ---------------------------------------------------------------------

proj_dir <- "/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"
models_sum_fp <- glue("{proj_dir}/med/gsim__reg_sibsum_on_sibdiff_simulated_gts.txt")


fit_and_save_models <- function(data, rsid_value) {

  # Step 1: Filter the dataframe for the given rsid
  filtered_data <- data %>% filter(rsid == rsid_value)
  print(nrow(filtered_data))

  # Check if the filtered data is not empty
  if (nrow(filtered_data) == 0) {
    stop("No data found for the given rsid.")
  }

  model <- lm(sib1_plus_sib2_gt ~ sib1_minus_sib2_gt, data = filtered_data)

  # Capture the summary of the model
  model_summary <- capture.output(summary(model))

  # Append the summary to the file
  write(c(paste("Model summary for rsid: ", rsid_value), model_summary, "\n\n"), models_sum_fp, append = TRUE)

  return(model)
}


get_models_details <- function(model, rsid_value, coefs_df, model_metrics_df) {
  # Extract coefficients and statistics
  co_df <- broom::tidy(model)
  co_df[["rsid"]] <- rsid_value

  # Extract model-level statistics
  metrics_df <- glance(model)
  metrics_df[["rsid"]] <- rsid_value

  # Concatenate co_df to coefs_df
  coefs_df <- rbind(coefs_df, co_df)

  # Concatenate metrics_df to model_metrics_df
  model_metrics_df <- rbind(model_metrics_df, metrics_df)

  # Return both updated dataframes as a list
  return(list(coefs_df = coefs_df, model_metrics_df = model_metrics_df))
}


# read models data
df <- arrow::read_parquet(glue("{proj_dir}/med/reg_data__simulated_sib_pairs_gts.parquet"))
head(df)

# Example usage
exmple_rsid <- "1"

model <- fit_and_save_models(
  data = df,
  rsid_value = exmple_rsid
)
summary(model)

models_details <- get_models_details(model, exmple_rsid, data.frame(), data.frame())
models_details$coefs_df
models_details$model_metrics_df


# do for all the rsids
# Get unique rsid values
unique_rsids <- unique(df$rsid)
head(unique_rsids)

combined_coef_dfs <- data.frame()
combined_model_metrics_df <- data.frame()


# Loop through each unique rsid
for (rsid in unique_rsids) {
  # Apply the function
  m <- fit_and_save_models(data = df, rsid = rsid)

  # Print a message to track progress
  cat("Processed rsid:", rsid, "\n")

  models_details <- get_models_details(m, rsid, combined_coef_dfs, combined_model_metrics_df)
  combined_coef_dfs <- models_details$coefs_df
  combined_model_metrics_df <- models_details$model_metrics_df
}


head(combined_coef_dfs)
write.csv(combined_coef_dfs, glue("{proj_dir}/med/gSim__models_coefs.csv", row.names=F))

head(combined_model_metrics_df)
write.csv(combined_model_metrics_df, glue("{proj_dir}/med/gSim__models_metrics.csv", row.names=F))

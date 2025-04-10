list.of.packages <- c("data.table", "dplyr", "magrittr", "tidyverse", "arrow", "broom", "glue", "writexl")
lapply(list.of.packages, library, character.only = TRUE)


dta_dir <- "/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data"
output_fp <- "/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out/lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_summary.txt"


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
  write(c(paste("Model summary for rsid: ", rsid_value), model_summary, "\n\n"), output_fp, append = TRUE)

  return(model)
}


# read models data
df <- read_parquet(glue("/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/med/all_sibs_pairs_rsid_chr22_maf_sib1_gt_sib2_gt.parquet"))
head(df)


# Example usage
exmple_rsid <- "rs117051531"

model <- fit_and_save_models(
  data = df,
  rsid_value = exmple_rsid
)
summary(model)


get_models_details <- function(model, rsid_value, coefs_df, model_metrics_df) {
  # Extract coefficients and statistics
  co_df <- tidy(model)
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


# Example usage
models_details <- get_models_details(model, exmple_rsid, data.frame(), data.frame())
models_details$coefs_df
models_details$model_metrics_df


# Get unique rsid values
unique_rsids <- unique(df$rsid)

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

combined_coef_dfs

# add maf for each rsid
df_maf <- df %>%
  select(rsid, MAF) %>%
  distinct()

df_coef_1 <- combined_coef_dfs %>%
  left_join(df_maf, by = "rsid")

df_metrics_1 <- combined_model_metrics_df %>%
  left_join(df_maf, by = "rsid")


write_xlsx(df_coef_1, "/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out/lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_coefs.xlsx")
write_xlsx(df_metrics_1, "/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out/lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_metrics.xlsx")

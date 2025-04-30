list.of.packages <- c("data.table", "dplyr", "magrittr", "tidyverse", "plinkFile", "genio", "arrow", "broom", "glue", "sjPlot", "writexl", "readxl", "gt", "ggplot2", "patchwork", "cowplot")
lapply(list.of.packages, library, character.only = TRUE)
library(pander)
library(dplyr)
library(purrr)
library(broom)

fp <- "/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out_mirrored/all_sibs_pairs_rsid_chr22_maf_sib1_gt_sib2_gt.parquet"

df <- read_parquet(fp)
df <- na.omit(df)
head(df)

df %>%
  count(rsid)

results <- df %>%
  group_by(rsid, MAF) %>%
  summarise(
    var_sib1_gt = var(sib1_gt),
    var_sib2_gt = var(sib2_gt),
    cov_sib1_sib2 = cov(sib1_gt, sib2_gt),
    cor_test = list(cor.test(sib1_plus_sib2_gt, sib1_minus_sib2_gt)),
    .groups = "drop"
  ) %>%
  mutate(
    cor_estimate_g1PlusG2_g1MinusG2 = map_dbl(cor_test, ~ .x$estimate),
    cor_p_value_g1PlusG2_g1MinusG2 = map_dbl(cor_test, ~ .x$p.value),
    cor_conf_low_g1PlusG2_g1MinusG2 = map_dbl(cor_test, ~ .x$conf.int[1]),
    cor_conf_high_g1PlusG2_g1MinusG2 = map_dbl(cor_test, ~ .x$conf.int[2])
  ) %>%
  select(-cor_test)

print(results)

results %>% 
  count(rsid)

out_dir <- "/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/local/lm_g1_plus_g2_on_g1_minus_g2"
writexl::write_xlsx(results, glue("{out_dir}/sib1_sib2_gt_var_cov_and_corrTest_sib1PlusSib2_sib1MinusSib2.xlsx"))

dplyr::last_dplyr_warnings()

results[results$rsid == "rs2289713", ]

sink(glue("{out_dir}/1.txt"))
pander(results[results$rsid == "rs2289713", ], style = "grid")
sink()


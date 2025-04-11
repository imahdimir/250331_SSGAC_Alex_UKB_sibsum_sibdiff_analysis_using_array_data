list.of.packages <- c("data.table", "dplyr", "magrittr", "tidyverse", "plinkFile", "genio", "arrow", "broom", "glue", "sjPlot", "writexl", "readxl", "gt", "ggplot2", "patchwork", "cowplot")
lapply(list.of.packages, library, character.only = TRUE)
library(pander)

fp <- "/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out_mirrored/all_sibs_pairs_rsid_chr22_maf_sib1_gt_sib2_gt.parquet"

df <- read_parquet(fp)
head(df)


df <- na.omit(df)
head(df)


# keep rsid and MAF and drop other columns and drop duplicates
df_maf <- df %>%
  select(rsid, MAF) %>%
  distinct()

head(df_maf)
nrow(df_maf)


# create historgram of MAF
maf_hist <- ggplot(df_maf, aes(x = MAF)) +
  geom_histogram(alpha = 0.4, position = "identity", bins = 30, color = "black", fill = "steelblue") +
  labs(title = "MAF Distribution", x = "MAF", y = "Frequency") +
  theme_minimal()

print(maf_hist)

out_dir<-"/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/local/lm_g1_plus_g2_on_g1_minus_g2"
ggsave(glue("{out_dir}/maf_hist.pdf"), maf_hist, width = 8, height = 6)



##
head(df)
nrow(df)

df <- df %>%
  mutate(
    sib1_gt = as.numeric(sib1_gt),
    sib2_gt = as.numeric(sib2_gt),
  )

sink(glue("{out_dir}/sib1_gt_var_sib2_gt_var_sib1_sib2_gt_cor_test.txt"))

v1 <- var(df$sib1_gt)
v2 <- var(df$sib2_gt)
min_maf <- "1 Percent"
n_snps <- "2000"
chr <- "22"


table_data <- data.frame(
  Description = c("sib1 genotype var", "sib2 genotype var", "Min MAF", "N SNPs", "Chromosome"),
  Value = c(v1, v2, min_maf, n_snps, chr)
)


# Use pander to print the table with lines
pander(table_data, style = "grid")


# Print a separator
cat("\n---\n\n")

cor.test(df$sib1_gt, df$sib2_gt)

sink()


##
risd_1 <- "rs117051531"
df_1 <- df[df$rsid == risd_1, ]
head(df_1)
nrow(df_1)
cor.test(df_1$sib1_gt, df_1$sib2_gt)



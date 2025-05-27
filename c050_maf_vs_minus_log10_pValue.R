list.of.packages <- c("data.table", "dplyr", "magrittr", "tidyverse", "plinkFile", "genio", "arrow", "broom", "glue", "sjPlot", "writexl", "readxl", "gt", "ggplot2", "patchwork", "cowplot")
lapply(list.of.packages, library, character.only = TRUE)
library(pander)


fp <- "/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out_mirrored/lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_coefs.xlsx"
df <- read_excel(fp)

df_slope <- df %>%
  filter(term == "sib1_minus_sib2_gt")

df_slope[which.min(df_slope$p.value), ]

df_slope$minus_log10_p_value <- -log10(df_slope$p.value)
head(df_slope)


plot <- ggplot(df_slope, aes(x = MAF, y = minus_log10_p_value)) +
  geom_point(alpha = 0.6, color = "#2C3E50", size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "#E74C3C", linewidth = 1) +
  labs(
    title = expression("Relationship Between MAF and " * -log[10](p-value)),
    x = expression("MAF"),
    y = expression(-log[10](p-value))
  ) +
  theme_minimal(base_size = 22) +
  theme(
    plot.title = element_text(face = "bold", size = 24, hjust = 0.5),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank()
  )

print(plot)

out_dir <- "/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/local/lm_g1_plus_g2_on_g1_minus_g2"
ggsave(glue("{out_dir}/maf_vs_minus_log10_p-value.pdf"), plot = plot)


sink(glue("{out_dir}/maf_vs_minus_log10_p-value_cor_test.txt"))
cor.test(df_slope$MAF, df_slope$minus_log10_p_value)
sink()




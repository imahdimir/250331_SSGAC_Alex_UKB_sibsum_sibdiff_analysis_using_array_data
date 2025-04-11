list.of.packages <- c("data.table", "dplyr", "magrittr", "tidyverse", "plinkFile", "genio", "arrow", "broom", "glue", "sjPlot", "writexl", "readxl", "gt", "ggplot2", "patchwork", "cowplot")
lapply(list.of.packages, library, character.only = TRUE)


coefs_fp <- "/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out_mirrored/lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_coefs.xlsx"

df <- read_excel(coefs_fp)
head(df)


df <- na.omit(df)
head(df)


# Calculate empirical means for each term and quality
empirical_means <- df %>%
  group_by(term) %>%
  summarize(mean_estimate = mean(estimate), .groups = "drop")

empirical_means

# Define custom colors for vertical lines (ensuring clear distinction)
vline_colors <- c(
  "Theoretical Mean" = "black"
)

# Create the combined plot with legend
combined_plot_minus <- ggplot(df, aes(x = estimate)) +
  geom_histogram(alpha = 0.4, position = "identity", bins = 30, color = "black", fill = "steelblue") +

  # Theoretical Mean Lines
  geom_vline(data = subset(df, term == "sib1_minus_sib2_gt"),
             aes(xintercept = 0, color = "Theoretical Mean"), linewidth = 0.8, linetype = "dashed") +

  scale_color_manual(name = "Vertical Lines", values = vline_colors, guide = guide_legend(override.aes = list(
    linetype = "solid",   # Solid lines in legend
    linewidth = 2,        # Thicker for visibility
    size = .6  # Custom height of short lines
  ))) +
  facet_wrap(~term, scales = "free") +
  labs(title = "Intercept & Slope Histogram for g1 + g2 ~ g1 - g2", x = "Estimate", y = "Frequency") +
  theme_minimal() +
  theme(
    legend.position = "right",
    legend.spacing.y = unit(20, "pt"),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 10),
    legend.box = "vertical"
  )


print(combined_plot_minus)

out_dir <- "/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/local/lm_g1_plus_g2_on_g1_minus_g2"
ggsave(glue("{out_dir}/coefs_histograms.pdf"), plot = combined_plot_minus)


##


head(df)

df_slope <- df[df$term == 'sib1_minus_sib2_gt',]

pdf(glue("{out_dir}/slope_statistics_qq.pdf"), width = 10, height = 10)

qqnorm(df_slope$statistic, main = "Normal Q-Q Plot of Statistics for Slope")
abline(a = 0, b = 1, col = 2)


dev.off()

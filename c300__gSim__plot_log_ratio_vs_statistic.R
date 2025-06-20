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
pacman::p_load(readr, ggplot2, dplyr, tidyr, glue)

## ---------------------------------------------------------------------

proj_dir <- "/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"

fp <- glue("{proj_dir}/med/gSim__log_ratio_vs_statistic_plot_data.csv")
df <- readr::read_csv(fp)
head(df)
# A tibble: 6 × 5


plot <- ggplot(df, aes(x = statistic, y = log_ratio_variances)) +
  geom_point(alpha = 0.6, color = "#2C3E50", size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "#E74C3C", linewidth = 1) +
  labs(
    title = expression("Simulated Data - Relationship Between Statistic and " * log[10](sigma[g1]^2 / sigma[g2]^2)),
    x = expression("Statistic from sib-sum onto sib-difference regression"),
    y = expression(log[10](sigma[g1]^2 / sigma[g2]^2))
  ) +
  theme_minimal(base_size = 22) +
  theme(
    plot.title = element_text(face = "bold", size = 24, hjust = 0.5),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank()
  )

print(plot)


fp <- glue("{proj_dir}/out_fig/gSim__log_ratio_vs_statistic.pdf")
fp
scale <- 2
ggsave(fp, plot = plot, dpi = 300, width = 8 * scale, height = 6 * scale)

fp <- glue("{proj_dir}/out_fig/gSim__log_ratio_vs_statistic.png")
fp
ggsave(fp, plot = plot, dpi = 300, width = 8 * scale, height = 6 * scale)


cor.test(df$log_ratio_variances, df$statistic)

    # Pearson's product-moment correlation

    # data:  df$log_ratio_variances and df$statistic
    # t = 2879.5, df = 1998, p-value < 2.2e-16
    # alternative hypothesis: true correlation is not equal to 0
    # 95 percent confidence interval:
    #  0.9998685 0.9998897
    # sample estimates:
    #       cor
    # 0.9998795

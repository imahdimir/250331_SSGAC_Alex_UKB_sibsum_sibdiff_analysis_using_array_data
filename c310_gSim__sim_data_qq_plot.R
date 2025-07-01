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
pacman::p_load(readr, ggplot2, dplyr, tidyr, glue, qqplotr)

## ---------------------------------------------------------------------

proj_data_dir <- "/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"

# read in dosages models coefficients
fp <- file.path(proj_data_dir, 'med', 'gSim__models_coefs.csv')
df <- read.csv(fp)


# keep only sib1_minus_sib2_gt term
df <- df[df$term=='sib1_minus_sib2_gt',]


gg <- ggplot(data = df, mapping = aes(sample = statistic)) +
  stat_qq_band() +
  stat_qq_line() +
  stat_qq_point() +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles")
gg

fp <- file.path(proj_data_dir, 'out', 'gsim__qq_plot_sibsum_on_sibdiff_reg.png')
ggsave(fp, plot=gg, width = 6, height = 5, units = 'in', dpi = 300)

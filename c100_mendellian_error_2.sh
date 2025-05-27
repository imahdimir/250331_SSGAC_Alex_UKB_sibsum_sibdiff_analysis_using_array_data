#!/bin/bash

decomp_arr_dta_dir="/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped"
proj_dta_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"

bed_fp="$decomp_arr_dta_dir/ukb_cal_chr22_v2.bed"
bim_fp="$decomp_arr_dta_dir/ukb_snp_chr22_v2.bim"
fam_fp="$proj_dta_dir/med/fam_with_ped.fam"

plink19_exec="/homes/nber/alextisyoung/plink"

cd $proj_dta_dir/out/mendelian_error
$plink19_exec --bed $bed_fp --bim $bim_fp --fam $fam_fp --mendel --out mendel_errors

# Output:
# mendel_errors.log

# PLINK v1.90b6.18 64-bit (16 Jun 2020)
# Options in effect:
#   --bed /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_cal_chr22_v2.bed
#   --bim /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_snp_chr22_v2.bim
#   --fam /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/fam_with_ped.fam
#   --mendel
#   --out mendel_errors

# Hostname: genetics3
# Working directory: /disk/genetics4/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendelian_error
# Start time: Mon May 26 20:27:50 2025

# Random number seed: 1748305670
# 1031964 MB RAM detected; reserving 515982 MB for main workspace.
# 12968 variants loaded from .bim file.
# 490227 people (224259 males, 265957 females, 11 ambiguous) loaded from .fam.
# Ambiguous sex IDs written to mendel_errors.nosex .
# Error: Invalid .bed file size (expected 1589319179 bytes).

# End time: Mon May 26 20:27:51 2025


# output:
# mendel_errors.nosex

# -1      -1
# -2      -2
# -3      -3
# -4      -4
# -5      -5
# -6      -6
# -7      -7
# -8      -8
# -9      -9
# -10     -10
# -11     -11

mendel_err_1_dir="$proj_dta_dir/med/mendelian_error_1"
mkdir -p $mendel_err_1_dir
mv * $mendel_err_1_dir
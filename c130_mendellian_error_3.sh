#!/bin/bash

tmp_code_dir="/tmp/pycharm_project_285"
echo "temp_code_dir: $tmp_code_dir"

plink_exec="/homes/nber/alextisyoung/plink"

decomp_arr_dta_dir="/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped"
proj_dta_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"


bed_fp="$decomp_arr_dta_dir/ukb_cal_chr22_v2.bed"
bim_fp="$decomp_arr_dta_dir/ukb_snp_chr22_v2.bim"
fam_fp_0="$decomp_arr_dta_dir/all.fam"

fam_fp="$proj_dta_dir/med/fam_with_ped.fam"
head $fam_fp


$plink_exec --bed $bed_fp --bim $bim_fp --fam $fam_fp --mendel --out $proj_dta_dir/out/mendellian_error
# output:
  #PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  #(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  #Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendellian_error.log.
  #Options in effect:
  #  --bed /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_cal_chr22_v2.bed
  #  --bim /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_snp_chr22_v2.bim
  #  --fam /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/fam_with_ped.fam
  #  --mendel
  #  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendellian_error
  #
  #1031964 MB RAM detected; reserving 515982 MB for main workspace.
  #12968 variants loaded from .bim file.
  #490227 people (224259 males, 265957 females, 11 ambiguous) loaded from .fam.
  #Ambiguous sex IDs written to
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendellian_error.nosex
  #.
  #Error: Invalid .bed file size (expected 1589319179 bytes).

$plink_exec --bed $bed_fp --bim $bim_fp --fam $fam_fp_0 --mendel --out $proj_dta_dir/out/mendellian_error
# output:
  #PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  #(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  #Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendellian_error.log.
  #Options in effect:
  #  --bed /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_cal_chr22_v2.bed
  #  --bim /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_snp_chr22_v2.bim
  #  --fam /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/all.fam
  #  --mendel
  #  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendellian_error
  #
  #1031964 MB RAM detected; reserving 515982 MB for main workspace.
  #12968 variants loaded from .bim file.
  #488377 people (223507 males, 264859 females, 11 ambiguous) loaded from .fam.
  #Ambiguous sex IDs written to
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendellian_error.nosex
  #.
  #Using 1 thread (no multithreaded calculations invoked).
  #Before main variant filters, 488377 founders and 0 nonfounders present.
  #Calculating allele frequencies... done.
  #Total genotyping rate is 0.972879.
  #Warning: Skipping --me/--mendel since there are no trios.

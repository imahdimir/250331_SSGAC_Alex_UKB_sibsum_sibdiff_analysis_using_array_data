#!/bin/bash

tmp_code_dir="/tmp/pycharm_project_285"
echo "temp_code_dir: $tmp_code_dir"


plink_exec="/homes/nber/alextisyoung/plink"


decomp_arr_dta_dir="/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped"
proj_dta_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"
out_dir="$proj_dta_dir/out/mendellian_error_analysis"
mkdir -p $out_dir


bed_fp="$decomp_arr_dta_dir/ukb_cal_chr22_v2.bed"
bim_fp="$decomp_arr_dta_dir/ukb_snp_chr22_v2.bim"
fam_fp="$proj_dta_dir/med/fam_with_same_fid_for_po_pairs.fam"

$plink_exec --bed $bed_fp --bim $bim_fp --fam $fam_fp --mendel --out $out_dir/mendellian_error

# output:
  #PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  #(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  #Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendellian_error_analysis/mendellian_error.log.
  #Options in effect:
  #  --bed /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_cal_chr22_v2.bed
  #  --bim /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_snp_chr22_v2.bim
  #  --fam /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/fam_with_same_fid_for_po_pairs.fam
  #  --mendel
  #  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendellian_error_analysis/mendellian_error
  #
  #1031964 MB RAM detected; reserving 515982 MB for main workspace.
  #12968 variants loaded from .bim file.
  #139209 people (65292 males, 73917 females) loaded from .fam.
  #Error: Invalid .bed file size (expected 451325307 bytes).

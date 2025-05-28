#!/bin/bash

proj_dta_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"

mendel_error_dir="$proj_dta_dir/out/mendelian_error_3"
mkdir -p $mendel_error_dir

filtered_bed="$proj_dta_dir/med/filtered_bed"

plink19_exec="/homes/nber/alextisyoung/plink"

# Now I can run the mendellian error command
bed_fp="$filtered_bed/filtered__ukb_cal_chr22_v2.bed"
bim_fp="$filtered_bed/filtered__ukb_cal_chr22_v2.bim"
fam_fp="$filtered_bed/filtered__ukb_cal_chr22_v2.fam"

$plink19_exec --bed $bed_fp --bim $bim_fp --fam $fam_fp --mendel-duos --out $mendel_error_dir/mendellian_error

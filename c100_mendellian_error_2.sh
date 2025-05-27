#!/bin/bash

decomp_arr_dta_dir="/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped"
proj_dta_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"

bed_fp="$decomp_arr_dta_dir/ukb_cal_chr22_v2.bed"
bim_fp="$decomp_arr_dta_dir/ukb_snp_chr22_v2.bim"
fam_fp="$proj_dta_dir/med/fam_with_ped_nosex_ids_removed.fam"

plink19_exec="/homes/nber/alextisyoung/plink"

mendellian_error_dir="$proj_dta_dir/out/mendelian_error"
$plink19_exec --bed $bed_fp --bim $bim_fp --fam $fam_fp --mendel --out $mendellian_error_dir/mendellian_error

# output:
#PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
#(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
#Logging to mendel_errors.log.
#Options in effect:
#  --bed /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_cal_chr22_v2.bed
#  --bim /disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped/ukb_snp_chr22_v2.bim
#  --fam /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/fam_with_ped_nosex_ids_removed.fam
#  --mendel
#  --out mendel_errors
#
#1031964 MB RAM detected; reserving 515982 MB for main workspace.
#12968 variants loaded from .bim file.
#490216 people (224259 males, 265957 females) loaded from .fam.
#Error: Invalid .bed file size (expected 1589280275 bytes).

# I know .fam file has a smaller number of individuals than the .bed and .bim files.
# because I have removed some individuals from the .fam file. no sex ids were removed.
# making the .bed and .bim files compatible with .fam file

renamed_dta_dir="$proj_dta_dir/med/linked_but_renamed_dta/"
mkdir $renamed_dta_dir
ln -s $decomp_arr_dta_dir/ukb_cal_chr22_v2.bed $renamed_dta_dir
ln -s $decomp_arr_dta_dir/ukb_snp_chr22_v2.bim $renamed_dta_dir/ukb_cal_chr22_v2.bim
ln -s $decomp_arr_dta_dir/all.fam $renamed_dta_dir/ukb_cal_chr22_v2.fam


filtered_bed="$proj_dta_dir/med/filtered_bed/"
mkdir $filtered_bed
$plink19_exec --bfile $renamed_dta_dir/ukb_cal_chr22_v2 --keep $fam_fp --make-bed --out $filtered_bed/filtered__ukb_cal_chr22_v2


# Now I can run the mendellian error command
bed_fp_1="$filtered_bed/filtered__ukb_cal_chr22_v2.bed"
bim_fp_1="$filtered_bed/filtered__ukb_cal_chr22_v2.bim"
fam_fp_1="$filtered_bed/filtered__ukb_cal_chr22_v2.fam"

$plink19_exec --bed $bed_fp_1 --bim $bim_fp_1 --fam $fam_fp_1 --mendel --out $mendellian_error_dir/mendellian_error

# output:
#Before main variant filters, 488366 founders and 0 nonfounders present.
#Calculating allele frequencies... done.
#Total genotyping rate is 0.972879.
#Warning: Skipping --me/--mendel since there are no trios.

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

$plink19_exec --bed $bed_fp --bim $bim_fp --fam $fam_fp --mendel --mendel-duos --out $mendel_error_dir/mendellian_error

# output:
#Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendelian_error_3/mendellian_error.log.
#Options in effect:
#  --bed /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered_bed/filtered__ukb_cal_chr22_v2.bed
#  --bim /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered_bed/filtered__ukb_cal_chr22_v2.bim
#  --fam /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered_bed/filtered__ukb_cal_chr22_v2.fam
#  --mendel
#  --mendel-duos
#  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendelian_error_3/mendellian_error
#1031964 MB RAM detected; reserving 515982 MB for main workspace.
#12968 variants loaded from.bim file.
#488366 people (223507 males, 264859 females) loaded from.fam.
#Using 1 thread (no multithreaded calculations invoked).
#Before main variant filters, 488366 founders and 0 nonfounders present.
#Calculating allele frequencies... done.
#Total genotyping rate is 0.972879.
#Warning: Skipping --me/--mendel since there are no duos or trios.


# the output of the plink filtering has removed the pedigree information
head $fam_fp
# output:
#3733573 3733573 0 0 1 -9
#3571888 3571888 0 0 2 -9
#5560849 5560849 0 0 2 -9
#3873348 3873348 0 0 2 -9
#1263953 1263953 0 0 2 -9
#2387298 2387298 0 0 1 -9
#1095014 1095014 0 0 2 -9
#1087274 1087274 0 0 2 -9
#5072957 5072957 0 0 1 -9
#3981074 3981074 0 0 2 -9

# yes the pedigree information is removed
fam_fp_1="$proj_dta_dir/med/fam_with_ped_nosex_ids_removed.fam"

$plink19_exec --bed $bed_fp --bim $bim_fp --fam $fam_fp_1 --mendel --mendel-duos --out $mendel_error_dir/mendellian_error_v3.1

# output:
#Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendelian_error_3/mendellian_error_v3.1.log.
#Options in effect:
#  --bed /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered_bed/filtered__ukb_cal_chr22_v2.bed
#  --bim /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered_bed/filtered__ukb_cal_chr22_v2.bim
#  --fam /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/fam_with_ped_nosex_ids_removed.fam
#  --mendel
#  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendelian_error_3/mendellian_error_v3.1
#
#1031964 MB RAM detected; reserving 515982 MB for main workspace.
#12968 variants loaded from .bim file.
#490216 people (224259 males, 265957 females) loaded from .fam.
#Error: Invalid .bed file size (expected 1589280275 bytes).

# with the fam file with pedigree information, the command doesn't work

ped="/disk/genetics/ukb/alextisyoung/phenotypes/ukb.ped"
$plink19_exec --bfile $filtered_bed/filtered__ukb_cal_chr22_v2 --update-parents $ped --make-bed --out $filtered_bed/updated_filtered__ukb_cal_chr22_v2

# this approach didn't work still the pedigree information is not updated
rm $filtered_bed/*

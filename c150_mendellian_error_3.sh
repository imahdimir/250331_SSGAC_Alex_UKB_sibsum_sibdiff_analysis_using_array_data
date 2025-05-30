#!/bin/bash

tmp_code_dir="/tmp/pycharm_project_285"
echo "temp_code_dir: $tmp_code_dir"

plink_exec="/homes/nber/alextisyoung/plink"

proj_dta_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"
renamed_dta_dir="$proj_dta_dir/med/linked_but_renamed_dta/"

filtered_prefix="filtered__ukb_cal_chr22_v2"
filtered_dataset_dir="$proj_dta_dir/med/$filtered_prefix"
mkdir -p $filtered_dataset_dir


bfile_fp="$renamed_dta_dir/ukb_cal_chr22_v2"
fam_with_ped_no_sexids_removed_fp="$proj_dta_dir/med/fam_with_ped_nosex_ids_removed.fam"


$plink_exec --bfile $bfile_fp \
            --keep-fam $fam_with_ped_no_sexids_removed_fp \
            --make-bed \
            --out $filtered_dataset_dir/$filtered_prefix

# output: [successful run]
  #PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  #(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  #Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered__ukb_cal_chr22_v2/filtered__ukb_cal_chr22_v2.log.
  #Options in effect:
  #  --bfile /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/linked_but_renamed_dta//ukb_cal_chr22_v2
  #  --keep-fam /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/fam_with_ped_nosex_ids_removed.fam
  #  --make-bed
  #  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered__ukb_cal_chr22_v2/filtered__ukb_cal_chr22_v2
  #
  #1031964 MB RAM detected; reserving 515982 MB for main workspace.
  #12968 variants loaded from .bim file.
  #488377 people (223507 males, 264859 females, 11 ambiguous) loaded from .fam.
  #Ambiguous sex IDs written to
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered__ukb_cal_chr22_v2/filtered__ukb_cal_chr22_v2.nosex
  #.
  #--keep-fam: 488366 people remaining.
  #Warning: At least 1850 duplicate IDs in --keep-fam file.
  #Using 1 thread (no multithreaded calculations invoked).
  #Before main variant filters, 488366 founders and 0 nonfounders present.
  #Calculating allele frequencies... done.
  #Total genotyping rate in remaining samples is 0.972879.
  #12968 variants and 488366 people pass filters and QC.
  #Note: No phenotypes present.
  #--make-bed to
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered__ukb_cal_chr22_v2/filtered__ukb_cal_chr22_v2.bed
  #+
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered__ukb_cal_chr22_v2/filtered__ukb_cal_chr22_v2.bim
  #+
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered__ukb_cal_chr22_v2/filtered__ukb_cal_chr22_v2.fam
  #... done.


# replace the fam file with the one that has pedigree information
cp $fam_with_ped_no_sexids_removed_fp $filtered_dataset_dir/$filtered_prefix.fam


filtered_bfile_fp="$filtered_dataset_dir/$filtered_prefix"
mendellian_error_dir="$proj_dta_dir/out/mendelian_error"
mkdir -p $mendellian_error_dir

# let's try the mendellian error command again
$plink_exec --bfile $filtered_bfile_fp \
            --mendel \
            --out $mendellian_error_dir/mendellian_error

# output: [not successful run] still no success, no trios or duos
  #PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  #(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  #Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendelian_error/mendellian_error.log.
  #Options in effect:
  #  --bfile /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/filtered__ukb_cal_chr22_v2/filtered__ukb_cal_chr22_v2
  #  --mendel
  #  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/out/mendelian_error/mendellian_error
  #
  #1031964 MB RAM detected; reserving 515982 MB for main workspace.
  #12968 variants loaded from .bim file.
  #490216 people (224259 males, 265957 females) loaded from .fam.
  #Error: Invalid .bed file size (expected 1589280275 bytes).


# clenup
rm -rf $filtered_dataset_dir

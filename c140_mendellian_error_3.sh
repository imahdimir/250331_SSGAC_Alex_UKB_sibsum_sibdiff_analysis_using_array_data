#!/bin/bash

tmp_code_dir="/tmp/pycharm_project_285"
echo "temp_code_dir: $tmp_code_dir"

plink_exec="/homes/nber/alextisyoung/plink"

decomp_arr_dta_dir="/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped"
proj_dta_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"
data_with_ped="$proj_dta_dir/med/data_with_ped"
mkdir -p $data_with_ped


renamed_dta_dir="$proj_dta_dir/med/linked_but_renamed_dta/"
mkdir $renamed_dta_dir
ln -s $decomp_arr_dta_dir/ukb_cal_chr22_v2.bed $renamed_dta_dir
ln -s $decomp_arr_dta_dir/ukb_snp_chr22_v2.bim $renamed_dta_dir/ukb_cal_chr22_v2.bim
ln -s $decomp_arr_dta_dir/all.fam $renamed_dta_dir/ukb_cal_chr22_v2.fam


bfile_fp="$renamed_dta_dir/ukb_cal_chr22_v2"

ped_fp="/disk/genetics/ukb/alextisyoung/phenotypes/ukb.ped"

$plink_exec --bfile $bfile_fp \
            --update-parents $ped_fp \
            --make-bed \
            --out $data_with_ped/wiht_ped__ukb_cal_chr22_v2
# output:
  #PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  #(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  #Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/data_with_ped/wiht_ped__ukb_cal_chr22_v2.log.
  #Options in effect:
  #  --bfile /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/linked_but_renamed_dta//ukb_cal_chr22_v2
  #  --make-bed
  #  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/data_with_ped/wiht_ped__ukb_cal_chr22_v2
  #  --update-parents /disk/genetics/ukb/alextisyoung/phenotypes/ukb.ped
  #
  #1031964 MB RAM detected; reserving 515982 MB for main workspace.
  #12968 variants loaded from .bim file.
  #488377 people (223507 males, 264859 females, 11 ambiguous) loaded from .fam.
  #Ambiguous sex IDs written to
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/data_with_ped/wiht_ped__ukb_cal_chr22_v2.nosex
  #.
  #--update-parents: 0 people updated, 46404 IDs not present.
  #Using 1 thread (no multithreaded calculations invoked).
  #Before main variant filters, 488377 founders and 0 nonfounders present.
  #Calculating allele frequencies... done.
  #Total genotyping rate is 0.972879.
  #12968 variants and 488377 people pass filters and QC.
  #Note: No phenotypes present.
  #--make-bed to
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/data_with_ped/wiht_ped__ukb_cal_chr22_v2.bed
  #+
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/data_with_ped/wiht_ped__ukb_cal_chr22_v2.bim
  #+
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/data_with_ped/wiht_ped__ukb_cal_chr22_v2.fam
  #... done.

cd $data_with_ped
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/data_with_ped
  #wiht_ped__ukb_cal_chr22_v2.bed  wiht_ped__ukb_cal_chr22_v2.fam  wiht_ped__ukb_cal_chr22_v2.nosex
  #wiht_ped__ukb_cal_chr22_v2.bim  wiht_ped__ukb_cal_chr22_v2.log

head $data_with_ped/wiht_ped__ukb_cal_chr22_v2.fam
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

# still we have nosex ids in the data and the fam file has no pedigree information

# clean up
cd $tmp_code_dir
rm -rf $data_with_ped

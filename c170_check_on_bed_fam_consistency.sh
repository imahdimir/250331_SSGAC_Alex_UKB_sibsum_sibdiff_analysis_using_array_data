#!/bin/bash

# To test whether the issue with the mendellian error is due to the fam file
# being incompatible with the bed and bim files
# testing for compatibility of the original .fam file with the .bed and .bim files


tmp_code_dir="/tmp/pycharm_project_285"
echo "temp_code_dir: $tmp_code_dir"


proj_data_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"
renamed_dta_dir="$proj_data_dir/med/linked_but_renamed_dta/"
out_data_dir="$proj_data_dir/med/out_c170"
mkdir -p $out_data_dir


plink_exec="/homes/nber/alextisyoung/plink"


bfile_prefix="$renamed_dta_dir/ukb_cal_chr22_v2"
all_fam_fp="$bfile_prefix.fam"
keep_test_fp="$proj_data_dir/med/keep_test_c170.txt"


# filtering the first 1000 individuals from the .fam file
# to test if bed and fam is compatible or not
# if they are incompatible the following filtering command should fail

head -n 1000 $all_fam_fp | cut -d' ' -f1,2 > $keep_test_fp

$plink_exec --bfile $bfile_prefix \
            --keep  $keep_test_fp \
            --make-bed \
            --out $out_data_dir/subset_bed

# output:
  #PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  #(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  #Logging to /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/out_c170/subset_bed.log.
  #Options in effect:
  #  --bfile /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/linked_but_renamed_dta//ukb_cal_chr22_v2
  #  --keep /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/keep_test_c170.txt
  #  --make-bed
  #  --out /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/out_c170/subset_bed
  #
  #1031964 MB RAM detected; reserving 515982 MB for main workspace.
  #12968 variants loaded from .bim file.
  #488377 people (223507 males, 264859 females, 11 ambiguous) loaded from .fam.
  #Ambiguous sex IDs written to
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/out_c170/subset_bed.nosex
  #.
  #--keep: 1000 people remaining.
  #Using 1 thread (no multithreaded calculations invoked).
  #Before main variant filters, 1000 founders and 0 nonfounders present.
  #Calculating allele frequencies... done.
  #Total genotyping rate in remaining samples is 0.972645.
  #12968 variants and 1000 people pass filters and QC.
  #Note: No phenotypes present.
  #--make-bed to
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/out_c170/subset_bed.bed
  #+
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/out_c170/subset_bed.bim
  #+
  #/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/out_c170/subset_bed.fam
  #... done.

# the filtering command was successful so the .fam file is compatible with the .bed and .bim files
# but when I add pedigree information to the .fam file the compatibility is lost

# clenup
rm -f $keep_test_fp
rm -rf $out_data_dir

#!/bin/bash

proj_data_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"
filtered_bed="$proj_data_dir/med/filtered_bed"
renamed_dta_dir="$proj_data_dir/med/linked_but_renamed_data"

fam_fp="$proj_data_dir/med/fam_with_ped_nosex_ids_removed.fam"

keep_fp="$proj_data_dir/med/keep.txt"
# Use awk to extract the first two columns and save to keep.txt
awk '{print $1, $2}' "$fam_fp" > "$keep_fp"
head $keep_fp

plink_exec="/homes/nber/alextisyoung/plink"
$plink_exec --bfile $renamed_dta_dir/ukb_cal_chr22_v2 --keep $fam_fp --make-bed --out $filtered_bed/filtered__ukb_cal_chr22_v2

# still the problme persists, we still have the nosex ids that are present in the data

# clean up
rm -rf "$filtered_bed"
rm $keep_fp

renamed_dta_dir="$proj_data_dir/med/linked_but_renamed_dta"
rm $renamed_dta_dir/ukb_cal_chr22_v2.fam

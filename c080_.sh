bed_fp="/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/i24_n1_SSGAC_OnlyOnNBERserver_MahdiUKBws_UKB_NON_PROJECT_DATA_UKBv3_raw_genotyped_decompressed/ukb_cal_chr22_v2.bed"
bim_fp="/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/i24_n1_SSGAC_OnlyOnNBERserver_MahdiUKBws_UKB_NON_PROJECT_DATA_UKBv3_raw_genotyped_decompressed/ukb_snp_chr22_v2.bim"
fam_fp="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/med/fam_with_ped.fam"

cd /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out/mendelian_error

/homes/nber/alextisyoung/plink --bed $bed_fp --bim $bim_fp --fam $fam_fp --mendel --out mendel_errors

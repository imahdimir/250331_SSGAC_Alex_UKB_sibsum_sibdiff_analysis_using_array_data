from pathlib import Path


PD_RAND_STATE = 42


class Directory :
    dta = '/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data'
    dta = Path(dta)

    inp = dta / 'inp'
    med = dta / 'med'
    out = dta / 'out'

    out_synced = '/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out_synced'
    out_synced = Path(out_synced)

    genotyped_data_decompressed = '/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/i24_n1_SSGAC_OnlyOnNBERserver_MahdiUKBws_UKB_NON_PROJECT_DATA_UKBv3_raw_genotyped_decompressed'
    genotyped_data_decompressed = Path(genotyped_data_decompressed)


class FilePath :
    d = Directory()

    chr22_bed = d.genotyped_data_decompressed / 'ukb_cal_chr22_v2.bed'
    chr22_bim = d.genotyped_data_decompressed / 'ukb_snp_chr22_v2.bim'
    all_fam = d.genotyped_data_decompressed / 'all.fam'

    maf = '/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/24Q1/240317_CSF_SSGAC_Alex_UKB_imputed_gt_corr/med/mfi_v3.prq'

    select_snps_with_maf_chr22 = d.med / 'select_snps_with_maf_chr22.parquet'


class FilePathPattern :
    d = Directory()


class Var :
    rsid = 'rsid'
    maf = 'MAF'


##
def rsync__run_locally() :
    pass

    ##

    from i6_rsync.rsync import \
        make_rsync_cmds_and_copy_desired_one_to_clipboard_and_execute


    ##
    d = Directory()

    ##
    make_rsync_cmds_and_copy_desired_one_to_clipboard_and_execute('g01' ,
                                                                  d.out ,
                                                                  d.out_synced ,
                                                                  1 ,
                                                                  True)

    ##


    ##

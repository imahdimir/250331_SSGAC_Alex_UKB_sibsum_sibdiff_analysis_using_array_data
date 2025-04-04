#!/homes/nber/mahdimir/bulk/.pyenv/versions/3.12.2/envs/i5i0_SSGAC_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/bin/python3

"""


"""

from pathlib import Path


PD_RAND_STATE = 42


class Directory :
    dta = '/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/25Q1/i5i1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data'
    dta = Path(dta)

    inp = dta / 'inp'
    med = dta / 'med'
    out = dta / 'out'

    out_synced = '/Users/mmir/Library/CloudStorage/Dropbox/git/i5i2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/i5i1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out_synced'
    out_synced = Path(out_synced)

    genotyped_data = Path('/disk/genetics2/ukb/orig/UKBv3/genotyped_data')


class FilePath :
    d = Directory()

    maf = '/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/24Q1/240317_CSF_SSGAC_Alex_UKB_imputed_gt_corr/med/mfi_v3.prq'

    cal_chr22_bed_gz = d.genotyped_data / 'ukb_cal_chr22_v3.bed.gz'

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

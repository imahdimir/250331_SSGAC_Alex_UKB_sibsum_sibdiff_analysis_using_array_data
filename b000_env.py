from pathlib import Path


class Directory :
    dta = '/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2'
    dta = Path(dta)

    inp = dta / 'inp'
    med = dta / 'med'
    out = dta / 'out'

    out_mirrored = '/Users/mmir/Library/CloudStorage/Dropbox/git/i19_n2_SSGAC_tA2_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/i18_n1_SSGAC_tA1_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/out_mirrored'
    out_mirrored = Path(out_mirrored)

    genotyped_data_decompressed = '/disk/genetics/ukb/mahdimir/UKB_NON_PROJECT_DATA/decompressed__UKBv3_raw_genotyped'
    genotyped_data_decompressed = Path(genotyped_data_decompressed)

    linked_but_renamed_data = med / 'linked_but_renamed_data'


class FilePath :
    d = Directory()

    chr22_bed = d.genotyped_data_decompressed / 'ukb_cal_chr22_v2.bed'
    chr22_bed_in_linked_but_renamed_data = d.linked_but_renamed_data / chr22_bed.name
    chr22_bim = d.genotyped_data_decompressed / 'ukb_snp_chr22_v2.bim'
    all_fam = d.genotyped_data_decompressed / 'all.fam'

    maf = '/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/24Q1/240317_CSF_SSGAC_Alex_UKB_imputed_gt_corr/med/mfi_v3.prq'

    select_snps_chr22_with_maf_gt_1_pct = d.med / 'select_snps_chr22_with_maf_gt_1_pct.parquet'
    ukb_sibs_pair_iid = '/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/24Q2/5A240425_FS_corr_conditional_on_IBD/med/sibs.prq'
    ukb_all_sibs_iid_list = d.med / 'ukb_all_sibs_iid_list.csv'

    all_sibs_select_snps_chr22_genotype = d.med / 'all_sibs_select_snps_chr22_genotype.parquet'

    all_sibs_all_select_snps_chr22_product = d.med / 'all_sibs_all_select_snps_chr22_product.parquet'
    all_sibs_pairs_rsid_chr22_maf_sib1_gt_sib2_gt = d.med / 'all_sibs_pairs_rsid_chr22_maf_sib1_gt_sib2_gt.parquet'

    lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_summary = d.out / 'lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_summary.txt'
    lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_coefs = d.out / 'lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_coefs.xlsx'
    lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_metrics = d.out / 'lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_metrics.xlsx'

    ukb_ped = "/disk/genetics/ukb/alextisyoung/phenotypes/ukb.ped"

    fam_with_ped = d.med / 'fam_with_ped.fam'

    fam_with_ped_nosex_ids_removed = d.med / 'fam_with_ped_nosex_ids_removed.fam'

    fam_with_same_fid_for_po_pairs = d.med / 'fam_with_same_fid_for_po_pairs.fam'

    genome_err_obj = d.med / 'genome_err.pkl'

    mend_err_vs_minus_log10_pvalue_data = d.out / 'mend_err_vs_minus_log10_pvalue.csv'


class FilePathPattern :
    d = Directory()


class Constants :
    pd_rand_state_4_reproducibility = 42

    rsid = 'rsid'
    maf = 'MAF'
    sib1 = 'sib1'
    sib2 = 'sib2'
    iid = 'IID'
    genotype = 'genotype'
    sib1_gt = 'sib1_gt'
    sib2_gt = 'sib2_gt'
    sib1_plus_sib2_gt = 'sib1_plus_sib2_gt'
    sib1_minus_sib2_gt = 'sib1_minus_sib2_gt'
    fid = 'FID'
    father_id = 'FATHER_ID'
    mother_id = 'MOTHER_ID'
    mend_error_estimate = 'mendellian_error_estimate'
    term = 'term'
    pvalue = 'p.value'
    minus_log10_pvalue = '-log10_p.value'


class Parameters :
    select_snps_chr22_with_maf_gt_1_pct_count = 2000
    min_maf = 1 / 100  # 1 percent


# temp
d = Directory()
fp = FilePath()
c = Constants()


##
def rsync__run_locally() :
    pass

    ##
    from i6_rsync import \
        print_rsync_cmds_and_copy_desired_one_to_clipboard_and_execute
    from i6_rsync import rsync_loop


    ##
    d = Directory()

    _host = 'g01'
    _remote = d.out
    _local = d.out_mirrored
    _to_clipboard = 3
    _to_exec = _to_clipboard
    _delay = 60

    _f = print_rsync_cmds_and_copy_desired_one_to_clipboard_and_execute

    ##

    # -help
    _f(_host , _remote , _local)

    ##
    _f(_host , d.out , d.out_mirrored , _to_clipboard , _to_exec)

    ##
    rsync_loop(_host , _remote , _local , _to_exec , _delay)

    ##


##
def _draft() :
    pass

    ##
    from pyperclip import copy


    fp = FilePath()
    d = Directory()

    ##
    copy(fp.all_sibs_pairs_rsid_chr22_maf_sib1_gt_sib2_gt)

    ##
    copy(fp.lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_coefs)

    ##
    copy(fp.lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_metrics)



    ##



    ##

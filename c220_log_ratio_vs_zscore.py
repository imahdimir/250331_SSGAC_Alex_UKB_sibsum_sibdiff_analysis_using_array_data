"""


"""

import numpy as np
import pandas as pd
from bed_reader import open_bed
from i7_hot_reload.hot_reload import hot_reload_a_module_from_cwd
from snipar.errors import estimate_genotyping_error_rate
from snipar.pedigree import get_sibpairs_from_ped
import pickle


b000_env = hot_reload_a_module_from_cwd('b000_env')

from b000_env import FilePath
from b000_env import Constants


##
def main() :
    pass

    ##
    fp = FilePath()
    c = Constants()

    ##
    _fp = fp.all_sibs_pairs_rsid_chr22_maf_sib1_gt_sib2_gt
    print(_fp)
    "[]: /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/all_sibs_pairs_rsid_chr22_maf_sib1_gt_sib2_gt.parquet"

    ##
    df = pd.read_parquet(_fp)
    print(df.shape)
        """(38580000 , 8)"""

    print(df.head())

    ##
    df_var = df[[c.rsid , c.sib1_gt , c.sib2_gt]]
    df_var.head()

    ##
    df_var = df_var.groupby(c.rsid)[['sib1_gt' , 'sib2_gt']].var()
    df_var = df_var.reset_index()
    print(df_var.shape)
        """(2000 , 3)"""
    print(df_var.head())

        """
                rsid   sib1_gt   sib2_gt
        0  rs1002622  0.062765  0.061698
        1  rs1003694  0.547366  0.540359
        2  rs1004689  0.435292  0.428155
        3  rs1005133  0.383066  0.382187
        4  rs1005241  0.494394  0.495954
        """

    ##
    df_var = df_var.rename(columns={
                            c.sib1_gt:c.var_sib1_gt,
                            c.sib2_gt:c.var_sib2_gt,})

    print(df_var.head())

    ##
    df_var[c.log_ratio] = np.log10(df_var[c.var_sib1_gt] / df_var[c.var_sib2_gt])

    ##
    _fp = fp.lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_coefs
    print(_fp)

    ##
    df_coefs = pd.read_excel(_fp, engine='openpyxl')

    ##
    msk = df_coefs[c.term].eq(c.sib1_minus_sib2_gt)

    df_coefs = df_coefs[msk]

    ##
    df_coefs = df_coefs[[c.rsid, c.statistic]]

    ##
    df_plot = df_var.merge(df_coefs, on=c.rsid, how='left')

    ##
    df_plot.to_csv(fp.plot_data__log_ratio_vs_statistic, index=False)

    ##




##


##
if __name__ == '__main__' :
    main()


##
def _test() :
    pass

    ##
    fp.plot_data__mend_err_vs_minus_log10_pvalue


    ##


    ##

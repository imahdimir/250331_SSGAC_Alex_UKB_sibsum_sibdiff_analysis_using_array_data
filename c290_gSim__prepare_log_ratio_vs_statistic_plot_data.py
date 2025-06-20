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
    _fp = fp.reg_data__simulated_sib_pairs_gts
    print(_fp)

    ##
    df = pd.read_parquet(_fp)
    print(df.shape)
        """(6000000, 7)"""

    print(df.head())

    ##
    df_var = df[[c.rsid , c.sib1_gt , c.sib2_gt]]
    df_var.head()

    """
    
      rsid  sib1_gt  sib2_gt
    0    1      0.0      0.0
    1    1      0.0      0.0
    2    1      0.0      0.0
    3    1      0.0      0.0
    4    1      0.0      0.0
    
    """

    ##
    df_var = df_var.groupby(c.rsid)[['sib1_gt' , 'sib2_gt']].var()
    df_var = df_var.reset_index()
    print(df_var.shape)
    """(2000 , 3)"""

    print(df_var.head())

    """
       rsid   sib1_gt   sib2_gt
    0     1  0.103965  0.103037
    1    10  0.443129  0.451606
    2   100  0.122152  0.118162
    3  1000  0.134642  0.134642
    4  1001  0.386621  0.388284
    
    """

    ##
    df_var = df_var.rename(columns={
                            c.sib1_gt:c.var_sib1_gt,
                            c.sib2_gt:c.var_sib2_gt,})

    print(df_var.head())

    ##
    df_var[c.log_ratio] = np.log10(df_var[c.var_sib1_gt] / df_var[c.var_sib2_gt])

    ##

    # now read the coefficients from the model, to merge statistics data with the log ratio data on rsid

    _fp = fp.gsim__models_coefs_csv
    print(_fp)

    ##
    df_coefs = pd.read_csv(_fp)

    df_coefs.head()

    """
       Unnamed: 0                term  estimate  ...  statistic        p.value  rsid
    0           1         (Intercept)  0.216331  ...  21.476300   2.755773e-95     1
    1           2  sib1_minus_sib2_gt  0.008461  ...   0.278164   7.809057e-01     1
    2           3         (Intercept)  0.487927  ...  33.700710  2.071079e-211     2
    3           4  sib1_minus_sib2_gt  0.055439  ...   1.743539   8.134196e-02     2
    4           5         (Intercept)  1.672002  ...  76.509655   0.000000e+00     3
    """

    ##

    # keep only the rows where term is 'sib1_minus_sib2_gt'

    msk = df_coefs[c.term].eq(c.sib1_minus_sib2_gt)

    df_coefs = df_coefs[msk]

    ##
    df_coefs = df_coefs[[c.rsid, c.statistic]]

    ##
    df_coefs[c.rsid] = df_coefs[c.rsid].astype('string')


    df_plot = df_var.merge(df_coefs, on=c.rsid, how='left')

    df_plot.head()

    """
    
       rsid  var_sib1_gt  var_sib2_gt  log_ratio_variances     statistic
    0     1     0.103965     0.103037         3.894769e-03  2.781639e-01
    1    10     0.443129     0.451606        -8.229673e-03 -6.076331e-01
    2   100     0.122152     0.118162         1.442517e-02  1.064710e+00
    3  1000     0.134642     0.134642        -1.575242e-09 -2.600828e-16
    4  1001     0.386621     0.388284        -1.863804e-03 -1.359820e-01
    
    """

    ##
    _fp = fp.gsim__log_ratio_vs_statistic_plot_data__csv
    df_plot.to_csv(_fp, index=False)

    ##




##


##
if __name__ == '__main__' :
    main()


##
def _test() :
    pass

    ##


    ##


    ##

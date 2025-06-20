"""


"""

import numpy as np
import pandas as pd
from bed_reader import open_bed
from i7_hot_reload.hot_reload import hot_reload_a_module_from_cwd
from snipar.errors import estimate_genotyping_error_rate
from snipar.pedigree import get_sibpairs_from_ped


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

    # read rsids from the BIM file
    with open(fp.sim_chr1_bim , 'r') as bim :
        rsids = [line.split()[1] for line in bim.readlines()]

    ##
    print(len(rsids))

    ##
    df = pd.DataFrame(rsids , columns = [c.rsid])
    df.head()

    """
    Out[18]: 
      rsid
    0    1
    1    2
    2    3
    3    4
    4    5
    """

    ##

    # read gt matrix from the BED file
    bed = open_bed(fp.sim_chr1_bed , )
    gt_matrix = bed.read()

    print(gt_matrix.shape)

    # out: (6000, 2000)

    ##

    # convert to DataFrame
    df_gt = pd.DataFrame(gt_matrix , columns = rsids , index = bed.iid)

    df_gt.head()

    """
             1    2    3    4    5    6  ...  1995  1996  1997  1998  1999  2000
    2_0_0  0.0  1.0  2.0  1.0  0.0  0.0  ...   0.0   0.0   0.0   0.0   0.0   1.0
    2_0_1  0.0  0.0  1.0  0.0  0.0  0.0  ...   0.0   0.0   0.0   0.0   0.0   1.0
    2_1_0  0.0  0.0  0.0  0.0  0.0  0.0  ...   0.0   0.0   0.0   0.0   0.0   1.0
    2_1_1  0.0  0.0  0.0  0.0  0.0  0.0  ...   1.0   0.0   0.0   0.0   0.0   1.0
    2_2_0  0.0  2.0  1.0  1.0  0.0  0.0  ...   1.0   0.0   0.0   0.0   1.0   1.0
    
    """

    ##

    # reshape to long format
    df_gt_long = df_gt.melt(var_name = c.rsid ,
                            value_name = c.genotype ,
                            ignore_index = False)

    df_gt_long.head()

    """
          rsid  genotype
    2_0_0    1       0.0
    2_0_1    1       0.0
    2_1_0    1       0.0
    2_1_1    1       0.0
    2_2_0    1       0.0
    
    """

    df_gt_long.tail()

    """
              rsid  genotype
    2_2997_1  2000       1.0
    2_2998_0  2000       0.0
    2_2998_1  2000       0.0
    2_2999_0  2000       0.0
    2_2999_1  2000       0.0
    
    """

    ##

    # make index a column named 'IID'

    df_gt_long = df_gt_long.reset_index()

    ##
    df_gt_long.columns = [c.iid , c.rsid , c.genotype]

    ##

    # rsid, sib1 iid, sib2 iid, sib1 genotype, sib2 genotype

    df_gt_long[c.is_sib1] = df_gt_long[c.iid].str.contains('_0$')
    df_gt_long.head()

    ##
    df_sib1 = df_gt_long[df_gt_long[c.is_sib1]].copy()

    df_sib2 = df_gt_long[~df_gt_long[c.is_sib1]].copy()

    df_sib1.head()

    ##
    df_sib1 = df_sib1.drop(columns = [c.is_sib1])
    df_sib1.columns = [c.sib1_iid , c.rsid , c.sib1_gt]
    df_sib1.head()

    ##
    df_sib2 = df_sib2.drop(columns = [c.is_sib1])
    df_sib2.columns = [c.sib2_iid , c.rsid , c.sib2_gt]

    df_sib2.head()

    ##

    df_sib1[df_sib2.columns] = df_sib2[df_sib2.columns].to_numpy()

    df_sib1.head()

    ##
    df_sibs_gt = df_sib1[
        [c.rsid , c.sib1_iid , c.sib1_gt , c.sib2_iid , c.sib2_gt]]

    df_sibs_gt.head()

    ##

    # add sib1 + sib2 genotype and sib1 - sib2 genotype columns
    df_sibs_gt[c.sib1_plus_sib2_gt] = df_sibs_gt[c.sib1_gt] + df_sibs_gt[
        c.sib2_gt]

    df_sibs_gt[c.sib1_minus_sib2_gt] = df_sibs_gt[c.sib1_gt] - df_sibs_gt[
        c.sib2_gt]

    df_sibs_gt.head()

    ##

    # save to parquet file
    _fp = fp.reg_data__simulated_sib_pairs_gts

    df_sibs_gt.to_parquet(_fp , index = False)

    ##



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

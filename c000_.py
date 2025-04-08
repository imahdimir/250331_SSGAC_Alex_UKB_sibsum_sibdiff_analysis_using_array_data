"""


"""

import os
import pandas as pd
from pathlib import Path
import importlib
import sys
from i7_hot_reload.hot_reload import hot_reload_a_module_from_cwd
from bed_reader import open_bed


b000_ENV = hot_reload_a_module_from_cwd('b000_ENV')

from b000_ENV import Directory , FilePath , Constants , Parameters


def select_snps_on_chrom22_maf_gt_1_pct() :
    pass

    ##
    d = Directory()
    fp = FilePath()
    c = Constants()
    p = Parameters()

    ##
    with open(fp.chr22_bim , 'r') as bim :
        rsids = [line.split()[1] for line in bim.readlines()]

    ##
    print(len(rsids))

    ##
    df = pd.DataFrame(rsids , columns = [c.rsid])
    df.head()

    ##
    df_maf = pd.read_parquet(fp.maf)
    df_maf.head()

    ##
    df_maf = df_maf[[c.rsid , c.maf]]
    df_maf.head()

    ##
    df = df.merge(df_maf , on = c.rsid , how = 'left')
    df.head()

    ##
    print(df.shape)
    df = df.dropna()
    print(df.shape)

    ##
    print(df.shape)
    df = df.drop_duplicates(subset = c.rsid , keep = False)
    print(df.shape)
    df.head()

    ##
    msk = df[c.maf] > p.min_maf

    print(df.shape)
    df = df[msk]
    print(df.shape)

    ##
    _n = p.select_snps_chr22_with_maf_gt_1_pct_count

    # for reproducibility
    _rnd_state = Constants.pd_rand_state_4_reproducibility

    df_select = df.sample(n = _n , random_state = _rnd_state)
    df_select.head()

    ##
    _fp = fp.select_snps_chr22_with_maf_gt_1_pct
    df_select.to_parquet(_fp , index = False)


##
def __() :
    pass

    ##
    df = pd.read_parquet(


    ##
    bed = open_bed(fp.chr22_bed ,
                   bim_location = fp.chr22_bim ,
                   fam_location = fp.all_fam)

    ##
    bed.read()


    ##



    ##



    ##


    ##

    ##



    ##


    ##


    ##


    ##


##
def main() :
    pass

    ##


    ##


    ##


##
if __name__ == '__main__' :
    main()

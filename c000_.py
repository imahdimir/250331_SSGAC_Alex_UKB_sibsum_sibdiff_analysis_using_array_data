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

from b000_ENV import Directory , FilePath , Var
from b000_ENV import PD_RAND_STATE


def select_snps_on_chr22_maf_gt_1_pct() :
    pass

    ##
    d = Directory()
    fp = FilePath()
    v = Var()

    ##
    with open(fp.chr22_bim , 'r') as bim :
        rsids = [line.split()[1] for line in bim.readlines()]

    ##
    print(len(rsids))

    ##
    df = pd.DataFrame(rsids , columns = [v.rsid])
    df.head()

    ##
    df_maf = pd.read_parquet(fp.maf)

    ##


    ##



    ##



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

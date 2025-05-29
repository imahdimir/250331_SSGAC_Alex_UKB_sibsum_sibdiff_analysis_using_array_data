"""


"""

import numpy as np
import pandas as pd
from bed_reader import open_bed
from i7_hot_reload.hot_reload import hot_reload_a_module_from_cwd


b000_env = hot_reload_a_module_from_cwd('b000_env')

from b000_env import FilePath
from b000_env import Constants


##
def rm_no_sex_ids() :
    pass

    ##
    fp = FilePath()
    c = Constants()

    ##
    df_fam = pd.read_csv(fp.fam_with_ped ,
                         sep = ' ' ,
                         header = None ,
                         dtype = 'string')
    print(df_fam.shape)
    print(df_fam.head())

    ##
    df_nosex = pd.read_csv(fp.nosex_ids ,
                           sep = '\t' ,
                           header = None ,
                           dtype = 'string')

    print(df_nosex.shape)
    print(df_nosex.head())

    ##
    msk = df_fam[1].isin(df_nosex[1])
    print(msk.sum())

    ##

    # drop nosex ids from fam
    df_fam = df_fam[~msk]


    ##
    _fp = fp.fam_with_ped_nosex_ids_removed
    df_fam.to_csv(_fp , sep = ' ' , header = False , index = False)

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
if __name__ == '__main__' :
    main()

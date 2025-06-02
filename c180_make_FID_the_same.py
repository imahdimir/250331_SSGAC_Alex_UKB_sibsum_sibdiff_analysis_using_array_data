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
def main() :
    pass

    ##
    fp = FilePath()

    ##
    _fp = fp.fam_with_ped_nosex_ids_removed

    df_fam = pd.read_csv(_fp ,
                         sep = ' ' ,
                         header = None ,
                         dtype = 'string')

    print(df_fam.shape)
        # []: (490216, 6)

    print(df_fam.head())
        # []:
        #         0        1  2  3  4           5
        # 0  3733573  3733573  0  0  1  Batch_b001
        # 1  3571888  3571888  0  0  2  Batch_b001
        # 2  5560849  5560849  0  0  2  Batch_b001
        # 3  3873348  3873348  0  0  2  Batch_b001
        # 4  1263953  1263953  0  0  2  Batch_b001

    ##

    # drop duplicates
    _n0 = df_fam.shape[0]

    print(df_fam.shape)
        # []: (490216, 6)

    df_fam = df_fam.drop_duplicates()

    _n1 = df_fam.shape[0]

    print(f'Dropped {_n0 - _n1} duplicates')
        # []: Dropped 0 duplicates

    print(df_fam.shape)
        # []: (490216, 6)


    ##

    # drop without father and mother ids
    _n0 = df_fam.shape[0]

    msk = df_fam[2].eq('0') & df_fam[3].eq('0')

    df_fam_1 = df_fam[~msk]

    _n1 = df_fam_1.shape[0]

    print(f'Dropped {_n0 - _n1} without both father and mother ids')
        # []: Dropped 443813 without both father and mother ids

    print(df_fam_1.shape)
        # []: (46403, 6)

    ##

    # reindex FIDs
    df_fam_1.loc[:, 0] = np.arange(df_fam_1.shape[0]).astype(str)

    ##

    df_father = df_fam_1[[0, 2, 4]]
    df_father.columns = [0, 1, 4]
    df_father.loc[:, 4] = '1'

    df_mother = df_fam_1[[0, 3, 4]]
    df_mother.columns = [0, 1, 4]
    df_mother.loc[:, 4] = '2'


    ##
    df_fam_2 = pd.concat([df_fam_1, df_father] , ignore_index=True)

    ##
    df_fam_2.tail()

    ##
    df_fam_2 = pd.concat([df_fam_2, df_mother] , ignore_index=True)
    df_fam_2.tail()

    ##
    df_fam_2 = df_fam_2.fillna('0')
    df_fam_2.tail()

    ##


    # now for each pair of po pairs, FID is the same,
    # although for siblings we will have different FIDs and duplicates

    df_fam_2.to_csv(fp.fam_with_same_fid_for_po_pairs ,
                    sep = ' ' ,
                    header = False ,
                    dtype = 'string',
                    index = False)

    ##
    df_fam_2 = pd.read_csv(fp.fam_with_same_fid_for_po_pairs ,
                           sep = ' ' ,
                           header = None ,
                           dtype = 'string')



##
if __name__ == '__main__' :
    main()

##
def _test():
    pass

    ##
    dfa = df_fam.loc[df_fam[1].eq('2708738') , :]


    ##

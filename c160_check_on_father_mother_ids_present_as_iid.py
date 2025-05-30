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
    c = Constants()

    ##
    _fp = fp.fam_with_ped_nosex_ids_removed
    df_fam = pd.read_csv(_fp ,
                         sep = ' ' ,
                         header = None ,
                         dtype = 'string')

    print(df_fam.shape)
    print(df_fam.head())

    ##
    father_ids = df_fam[2].unique()
    mother_ids = df_fam[3].unique()

    ##
    msk_father = df_fam[1].isin(father_ids)
    msk_mother = df_fam[1].isin(mother_ids)

    print(f'Count of father_ids in the IIDs: {msk_father.sum()}')
        # []: Count of father_ids in the IIDs: 1577

    print(f'Count of mother_ids in the IIDs: {msk_mother.sum()}')
        # []: Count of mother_ids in the IIDs: 3517

    ##
    _test = df_fam[0].eq(df_fam[1]).all()
    print(f'All FIDs equal to IIDs: {_test}')
        # []: All FIDs equal to IIDs: False

    ##



##
if __name__ == '__main__' :
    main()

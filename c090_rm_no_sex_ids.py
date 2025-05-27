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
    df_ped = pd.read_csv(fp.ukb_ped , sep = ' ' , dtype = 'string')
    print(df_ped.head())
    print(df_ped.shape)

    ##
    df_ped = df_ped[[c.iid , c.father_id , c.mother_id]]
    print(df_ped.head())

    ##
    df_fam = df_fam.rename(columns = {
            0 : c.fid ,
            1 : c.iid
            })

    ##
    df_fam = df_fam.merge(df_ped , on = [c.iid] , how = 'left')
    print(df_fam.shape)
    print(df_fam.head())

    ##
    df_fam[c.father_id].count() , df_fam[c.mother_id].count()

    ##
    df_fam[df_fam[c.father_id].notna() & df_fam[c.mother_id].notna()].shape[0]

    ##
    print(df_fam.head())

    ##
    df_fam[c.father_id] = df_fam[c.father_id].fillna('0')
    df_fam[c.mother_id] = df_fam[c.mother_id].fillna('0')

    ##
    print(df_fam.head())

    ##
    df_fam[2] = df_fam[c.father_id]
    df_fam[3] = df_fam[c.mother_id]

    ##
    df_fam = df_fam[[c.fid , c.iid , 2 , 3 , 4 , 5]]
    print(df_fam.head())

    ##
    df_fam.to_csv(fp.fam_with_ped , sep = ' ' , header = False , index = False)

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

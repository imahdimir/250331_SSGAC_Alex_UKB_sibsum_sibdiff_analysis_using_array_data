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

    ##
    _fp_1 = fp.chr22_bed_in_linked_but_renamed_data
    bedfiles = np.array([_fp_1.as_posix()])

    ##
    _fp_2 = fp.ukb_ped

    print('Reading pedigree from ' + _fp_2)
    ped = np.loadtxt(_fp_2 , dtype = str)
    if ped.shape[1] < 4 :
        raise (ValueError('Not enough columns in pedigree file'))
    elif ped.shape[1] > 4 :
        print('Warning: pedigree file has more than 4 columns. The first four columns only will be used')

    # Remove rows with missing parents
    sibpairs , ped = get_sibpairs_from_ped(ped)
    if sibpairs is None :
        raise (ValueError('No sibpairs found'))

    ##
    mean_err , genome_err = estimate_genotyping_error_rate(ped , bedfiles)

    # []: 5316 parent-offspring pairs found in /disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2/med/linked_but_renamed_data/ukb_cal_chr22_v2.bed

    ##
    print(f'Mean genotyping error rate: {mean_err:.6f}')

    # []: Mean genotyping error rate: 0.000888

    ##
    print(genome_err)
    # []: [<snipar.errors.g_error object at 0x7fa98e6c2760>]

    ##
    with open(fp.genome_err_obj , 'wb') as f :
        pickle.dump(genome_err , f)

    ##
    with open(fp.genome_err_obj , "rb") as file :
        genome_err_2 = pickle.load(file)
    print(genome_err_2)

    ##



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


    ##

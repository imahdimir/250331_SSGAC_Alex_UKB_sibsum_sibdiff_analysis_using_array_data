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
from b000_ENV import Directory, FilePath
from b000_ENV import PD_RAND_STATE




def select_snps_on_chr22() :
    pass

    ##
    d = Directory()
    fp = FilePath()

    ##
    bed = open_bed(fp.chr22_bed, bim_location=fp.chr22_bim ,fam_location=fp.all_fam)

    ##
    bed.read()  # Read the bed file to load the data into memory

    ##
    with open(fp.chr22_bim , 'r') as bim :
        rsids = [line.split()[1] for line in bim.readlines()]

    ##
    rsids

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

"""


"""

import importlib
import os
import pandas as pd
import sys
from bed_reader import open_bed
from i7_hot_reload.hot_reload import hot_reload_a_module_from_cwd
from pathlib import Path
import numpy as np


b000_ENV = hot_reload_a_module_from_cwd('b000_ENV')

from b000_ENV import Directory , FilePath , Constants , Parameters


##
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
def save_all_sibs_iids_as_a_list() :
    pass

    ##
    d = Directory()
    fp = FilePath()
    c = Constants()

    ##
    df = pd.read_parquet(fp.ukb_sibs_pair_iid)
    df.head()

    ##
    stacked = pd.concat([df[c.sib1] , df[c.sib2]] , ignore_index = True)
    stacked = stacked.to_frame(name = c.iid)
    stacked.head()

    ##
    stacked.to_csv(fp.ukb_all_sibs_iid_list , index = False)


##
def create_dataframe_of_all_sibs_select_snps_chr22_genotype() :
    pass

    ##
    fp = FilePath()
    c = Constants()

    ##
    _bed = fp.chr22_bed
    _bim = fp.chr22_bim
    _fam = fp.all_fam

    ##

    # find the indices of the SNPs in the bim file

    bim = pd.read_csv(_bim , sep = "\t" , header = None)
    bim.columns = ["chrom" , c.rsid , "cm" , "pos" , "allele1" , "allele2"]

    ##
    df_snps = pd.read_parquet(fp.select_snps_chr22_with_maf_gt_1_pct)
    df_snps.head()

    ##
    target_rsids = df_snps[c.rsid]
    print(target_rsids.shape)
    target_rsids.head()

    ##
    msk = bim[c.rsid].isin(target_rsids)
    snps_indices = bim[msk].index.to_numpy()
    print(snps_indices)
    print(snps_indices.shape)

    ##
    actual_target_rsids = bim[msk][c.rsid]
    print(actual_target_rsids.head())
    print(actual_target_rsids.shape)

    ##
    fam = pd.read_csv(_fam , sep = " " , header = None)
    fam.columns = ["fid" , c.iid , "father" , "mother" , "sex" , "phenotype"]

    fam.head()

    ##

    # find the indices of the individuals in the fam file

    df_iids = pd.read_csv(fp.ukb_all_sibs_iid_list)
    target_iids = df_iids[c.iid]

    print(target_iids.head())
    print(target_iids.shape)

    ##
    msk = fam[c.iid].isin(target_iids)

    individuals_indices = fam[msk].index.to_numpy()
    print(individuals_indices.shape)
    print(individuals_indices)

    ##
    actual_target_iids = fam[msk][c.iid]

    print(actual_target_iids.head())
    print(actual_target_iids.shape)

    ##

    # read the bed file and extract the genotypes for the selected SNPs and individuals
    bed = open_bed(_bed , bim_location = _bim , fam_location = _fam)

    ##
    select_genotypes = bed.read(np.s_[individuals_indices , snps_indices])
    print(select_genotypes.shape)
    print(select_genotypes)

    ##

    # convert the genotypes to a pandas DataFrame
    df_genotypes = pd.DataFrame(select_genotypes ,
                                columns = actual_target_rsids ,
                                index = actual_target_iids)

    print(df_genotypes.head())
    print(df_genotypes.shape)

    ##
    df_genotypes = df_genotypes.stack()
    print(df_genotypes.head())
    print(df_genotypes.shape)

    ##
    df_genotypes = df_genotypes.reset_index()
    print(df_genotypes.head())
    print(df_genotypes.shape)

    ##
    df_genotypes.columns = [c.iid , c.rsid , c.genotype]
    print(df_genotypes.head())

    ##
    df_genotypes = df_genotypes.dropna()
    print(df_genotypes.head())

    ##
    df_genotypes = df_genotypes.astype({
            c.iid      : 'string' ,
            c.rsid     : 'string' ,
            c.genotype : "Int8" ,
            })
    print(df_genotypes.head())

    ##
    _fp = fp.all_sibs_select_snps_chr22_genotype
    df_genotypes.to_parquet(_fp , index = False)

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


##
def main() :
    pass

    ##


    ##


    ##


##
if __name__ == '__main__' :
    main()

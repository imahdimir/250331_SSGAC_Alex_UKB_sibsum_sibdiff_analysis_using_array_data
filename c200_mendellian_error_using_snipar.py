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
    c = Constants()

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
    type(genome_err_2)
    # []: list

    ##
    type(genome_err_2[0])
    # []: snipar.errors.g_error

    ##
    _sid = genome_err_2[0].sid
    print(_sid)
    # []: array(['rs62224618', 'rs116911124', 'rs117578132', ..., 'rs3865764',
    #        'rs142680588', 'rs9616974'], dtype='<U13')

    ##
    _error_ests = genome_err_2[0].error_ests
    print(_error_ests)
    # []:[0.0019867471455918277 0.00679136332206662 0.044347037451973756 ...
    #  0.0002133574459267504 0.00016258218915748412 0.0001723526400149446]

    ##
    df_err_sid = pd.DataFrame({
            c.rsid                : _sid ,
            c.mend_error_estimate : _error_ests
            })
    df_err_sid

    ##
    _fp = fp.lm_g1_plus_g2_on_g1_minus_g2__2K_SNP_chr22_models_coefs
    df_coefs = pd.read_excel(_fp , engine = 'openpyxl')

    ##

    # drop intercept term data, keeping only sib1_minus_sib2_gt term

    msk = df_coefs[c.term].eq('sib1_minus_sib2_gt')

    df_coefs = df_coefs[msk]

    df_coefs = df_coefs[[c.rsid , c.pvalue]]

    ##
    df_plot = pd.merge(df_coefs , df_err_sid , on = c.rsid)
    df_plot.head()

        """
                  rsid               p.value  mendellian_error_estimate
        0  rs117051531  0.009789510875044172      0.0003107055287887167
        1    rs4819589    0.7940360862496347      0.0014973811746163068
        2     rs139149   0.05356273007067124     0.00016825086534365418
        3   rs79559969    0.6265559347649035      0.0004916187346058661
        4  rs117920541 1.823436546314805e-05      0.0004453615288499723
        
        """

    ##
    df_plot[c.minus_log10_pvalue] = -np.log10(df_plot[c.pvalue])

    ##
    _fp = fp.plot_data__mend_err_vs_minus_log10_pvalue
    df_plot.to_csv(_fp , index = False)

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
    fp.plot_data__mend_err_vs_minus_log10_pvalue


    ##


    ##

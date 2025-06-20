#!/bin/bash

proj_data_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"
med_dir="$proj_data_dir/med"
cd $med_dir
sim_dir="simulation_1_gen_of_sibs_using_snipar"
mkdir -p $sim_dir

conda activate snipar

# 2K snps to match the 2K snps in the UKB data
simulate.py 2000 0.5 sim/ --nfam 3000 --impute --n_am 20 --r_par 0.5 --save_par_gts

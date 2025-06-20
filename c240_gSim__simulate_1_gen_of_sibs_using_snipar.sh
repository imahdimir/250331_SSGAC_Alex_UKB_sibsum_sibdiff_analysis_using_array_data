#!/bin/bash

proj_data_dir="/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/i18/i18_g2"
med_dir="$proj_data_dir/med"
cd $med_dir
sim_dir="simulation_1_gen_of_sibs_using_snipar"
mkdir -p $sim_dir

conda activate snipar

# 2K snps to match the 2K snps in the UKB data
simulate.py 2000 0.5 $sim_dir/ --nfam 3000 --impute --n_am 1 --r_par 0.5 --save_par_gts

# output:
  # Simulating an initial generation by random-mating
  # Followed by 0 generations of random-mating
  # Followed by 1 generations of assortative mating
  # Generating first generation by random-mating
  # Simulating direct genetic effects
  # Computing phenotypes
  # Genetic variance: 0.5
  # Phenotypic variance: 1.0027
  # Heritability: 0.4987
  # Parental genotypic correlation: 0.0065
  # Mating 2
  # Matching assortatively
  # Parental phenotypic correlation: 0.4821
  # Computing final generation
  # Computing phenotypes
  # Sibling genotypic correlation: 0.5508
  # Sibling phenotypic correlation: 0.277
  # Genetic variance: 0.5671
  # Phenotypic variance: 1.0812
  # Heritability: 0.5245
  # Parental genotypic correlation: 0.2447
  # Saving variance components to simulation_1_gen_of_sibs_using_snipar/VCs.txt
  # Writing pedigree and last generation relatedness and phenotype files
  # Saving genotypes
  # Writing genotypes for chromosome 1
  # Imputing parental genotypes and saving
  # Writing IBD segments for chromosome 1

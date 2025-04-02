#!/homes/nber/mahdimir/bulk/.pyenv/versions/3.12.2/envs/250331_SSGAC_Alex_UKB_sibsum_sibdiff_analysis_using_array_data/bin/python3

"""


"""
import os
import pandas as pd
from pathlib import Path


class Directory :
    data_dir = '/disk/genetics/ukb/mahdimir/UKB_PROJECTS_DATA/25Q1/250331_CSF_SSGAC_Alex_UKB_sibsum_sibdiff_analysis_using_array_data'
    data_dir = Path(data_dir)
    dta = data_dir

    inp = dta / 'inp'
    med = dta / 'med'
    out = dta / 'out'

    ukb_genotype_dir = Path('/disk/genetics2/ukb/orig/UKBv3/genotyped_data')


class FilePath :
    d = Directory()

    cal_chr22_bed_gz_src = d.ukb_genotype_dir /'ukb_cal_chr22_v2.bed.gz'
    cal_chr22_bed_gz = d.inp / 'ukb_cal_chr22_v2.bed.gz'

    ukb_snp_chr22_bim_gz = d.ukb_genotype_dir / 'ukb_snp_chr22_v2.bim.gz'


    cal_chr22_bed = d.inp / 'ukb_cal_chr22_v2.bed'

    hap_fam_22_src = "/disk/genetics4/ukb/alextisyoung/haplotypes/ukb_hap_chr22_v2.fam"
    hap_fam_22 = d.inp / 'ukb_hap_chr22_v2.fam'
    cal_chr22_fam = d.inp / 'ukb_cal_chr22_v2.fam'


class FilePathPattern :
    d = Directory()


class Var :
    pass


def main() :
    pass

    ##
    d = Directory()
    fp = FilePath()

    ##
    def copy_input_files_into_project_data_folder() :
        """
        Copy input files into the project data folder.
        """
        pass

        ##
        src_file__dest_dir = {
                fp.cal_chr22_bed_gz_src : d.inp ,
                fp.hap_fam_22_src       : d.inp ,

                }

        for src , dest in src_file__dest_dir.items() :
            # Copy the file to the destination directory
            shutil.copy(src , dest_dir)
            print(f"Copied {src} to {dest_dir}")


    ##
    # Rename the file
    orig_file = fp.hap_fam_22
    renamed_file = fp.cal_chr22_fam

    os.rename(orig_file , renamed_file)

    print(f"File has been renamed from {orig_file} to {renamed_file}")

    ##




    ##
    bed_df = pd.read_csv(fp.cal_chr22_bed , sep = '\t' , header = None)

    # Display the first few rows of the dataframe
    print(bed_df.head())

    ##
    import numpy as np
    from bed_reader import open_bed , sample_file


    bed = open_bed(fp.cal_chr22_bed, bim_location = fp.ukb_snp_chr22_bim_gz, fam_location = fp.hap_fam_22_src)
    val = bed.read()
    print(val)

    ##
    [[1.  0. nan  0.][2.  0. nan  2.][0.
    1.
    2.
    0.]] >> > del bed


    ##





    ##


    ##


##
if __name__ == '__main__' :
    main()

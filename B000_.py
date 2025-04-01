#!/homes/nber/mahdimir/bulk/.pyenv/versions/3.12.2/envs/250331_CSF_SSGAC_Alex_sibsum_sibdiff_analysis_using_array_data/bin/python3

"""


"""

from pathlib import Path

import pandas as pd


class Directory :
    data_dir = '/var/genetics/ws/mahdimir/projects_data/25Q1/250331_CSF_SSGAC_Alex_sibsum_sibdiff_analysis_using_array_data'
    data_dir = Path(data_dir)
    dta = data_dir

    inp = dta / 'inp'
    med = dta / 'med'
    out = dta / 'out'


class FilePath :
    d = Directory()

    chr22 = '/disk/genetics2/ukb/orig/UKBv3/genotyped_data/ukb_cal_chr22_v2.bed.gz'


class FilePathPattern :
    d = Directory()


class Var :
    pass


def main() :
    pass

    ##
    fp = FilePath()

    ##
    import gzip
    import pandas as pd


    # Open the gzip file
    with gzip.open(fp.chr22 , 'rt') as f :
        # Read the file into a pandas DataFrame
        df = pd.read_csv(f , sep = '\t' , header = None)

    # Display the first few rows of the DataFrame
    print(df.head())

    ##
    import gzip


    # Open the gzip file in binary mode
    with gzip.open(fp.chr22 , 'rb') as f :
        # Read the contents of the file
        file_content = f.read()

    # Process the binary data as needed
    # For example, you can print the first few bytes
    print(file_content[:100])



    ##


    ##


    ##



    ##


    ##


##
if __name__ == '__main__' :
    main()

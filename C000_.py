#!/homes/nber/mahdimir/bulk/.pyenv/versions/3.12.2/envs/i5i0_SSGAC_Alex_UKB_sibsum_sibdiff_analysis_using_array_genotyped_data/bin/python3

"""


"""

import os
import pandas as pd
from bgen_reader import open_bgen
from pathlib import Path




def select_snps_on_chr22() :
    pass

    ##
    d = Directory()
    fp = FilePath()
    v = Var()

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


    bed = open_bed(fp.cal_chr22_bed ,
                   bim_location = fp.ukb_snp_chr22_bim_gz ,
                   fam_location = fp.hap_fam_22_src)
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
def main() :
    pass

    ##


    ##


    ##


##
if __name__ == '__main__' :
    main()


##
import pathlib
import pyperclip

def make_rsync_cmds_and_copy_desired_one_to_clipboard(local: pathlib.Path, remote : pathlib.Path, hostname : str, cmd_number_to_cp_clipboard = None):
    """
    rsync should be installed on both local and remote machines.
    host should be accessible via ssh f'{hostname}' (by setting up ssk key and ssh config)
    hostname: should be known to local machine and accessible via ssh hostname (ssh key and ssh confige must be set up)
    local: Path to the local directory where files will be synced to/from
    remote: Path to the remote directory where files will be synced to/from
    cmd_number_to_cp_clipboard: int, optional
    If provided, the corresponding rsync command will be copied to clipboard so it can be easily pasted into a terminal for execution.
    """

    cmds = {}

    print("1. sync from remote to local")
    cmds[1] = f"rsync -avz {hostname}:{remote}/ {local}"
    print(cmds[1], '\n')


    print("2. sync from local to remote")
    cmds[2] = f"rsync -avz {local}/ {hostname}:{remote}"
    print(cmds[2], '\n')


    print("3. sync from remote to local with delete option (remove files in local not present in remote)")
    cmds[3] = f"rsync -avz --delete {hostname}:{remote}/ {local}"
    print(cmds[3], '\n')

    print("4. sync from local to remote with delete option (remove files in remote not present in local)")
    cmds[4] = f"rsync -avz --delete {local}/ {hostname}:{remote}"
    print(cmds[4], '\n')

    if cmd_number_to_cp_clipboard is not None :
        pyperclip.copy(cmds[cmd_number_to_cp_clipboard])
        print(f"Command {cmd_number_to_cp_clipboard} copied to clipboard.")

    print('Run the desired cmd (might have been copied in clipboard) in local terminal to execute the rsync command.')

##
d = Directory()

##
make_rsync_cmds_copy_to_clipboard(d.out_synced, d.dta, 'g01', 3)

##
d.dta = d.dta / '1'

##
d.dta

##

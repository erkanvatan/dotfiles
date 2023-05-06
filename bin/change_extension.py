#!/usr/bin/env python3

import sys
import os
import subprocess

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("err: There must be at least one file name and result extension in the arguments.")
        print(f"usage: python3 {os.path.basename(__file__)} <result_file_extension> <filename1> <filename2> ...")
        sys.exit(2)
    
    result_extension = sys.argv[1]
    file_names = sys.argv[2:]
    for file in file_names:
        result = file[:(file.rfind(".") + 1)] + result_extension
        subprocess.run(["convert", file, result], check=True)

#!/usr/bin/env python
import sys
import os
import re

for file in sys.argv[1:]:
    if __file__ in file:
        continue
    words = re.split('_|\.', file)
    words[0] = words[0].zfill(2)
    new_name = '.'.join(words)
    os.rename(file, new_name)

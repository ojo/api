#! /usr/bin/env python
import sys
import string
from subprocess import call

# input is 'FOO="BAR"\n'
def transform_str_pair(pair):
    return pair.strip('\n').replace('"', '')


if __name__ == "__main__":
    dotenv_filename = sys.argv[1]
    with open(dotenv_filename) as f:
        strs = map(transform_str_pair, f.readlines())
        env_vars = string.join(strs)
        cmd = ["eb", "setenv"] + strs
        print string.join(cmd)
        call(cmd)


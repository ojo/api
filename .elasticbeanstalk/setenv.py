#! /usr/bin/env python
import re
import sys
import string
from subprocess import call

import argparse


try:
    input = raw_input
except NameError:
    pass


parser = argparse.ArgumentParser(description='Set EB ENV variables from .env files')
parser.add_argument('files', nargs='+', help='.env files')
parser.add_argument('--env', dest='env', help='EB environment to modify')


def setenv(env, files):
    cmd = ["eb", "setenv"]
    for dotenv_filename in files:
        with open(dotenv_filename) as f:
            strs = map(transform_str_pair, f.readlines())
            cmd = cmd + strs
    if env != None:
        cmd = cmd + ['-e', env]
    print string.join(cmd)
    proceed = prompt(
            message = "Would you like to proceed?",
            errormessage = "Answer y or n",
            isvalid = lambda v: re.search(r"(y|n)", v))
    if proceed == 'y':
        call(cmd)


# input is 'FOO="BAR"\n'
def transform_str_pair(pair):
    return pair.strip('\n').replace('"', '')


def prompt(message, errormessage, isvalid):
    """Prompt for input given a message and return that value after verifying the input.

    Keyword arguments:
    message -- the message to display when asking the user for the value
    errormessage -- the message to display when the value fails validation
    isvalid -- a function that returns True if the value given by the user is valid
    """
    res = None
    while res is None:
        res = input(str(message)+': ')
        if not isvalid(res):
            print str(errormessage)
            res = None
    return res


if __name__ == '__main__':
    args = parser.parse_args()
    env = args.env
    files = args.files
    setenv(env, files)

#!/usr/bin/env python
# coding: utf-8

import os
import sys

from .cli import parser

def execute(args):

    return 0


def main(argv=sys.argv):

    # under develop:
    # python -m setup-project => argv 2
    argv = argv[1:]

    if len(argv) == 0:
        parser.parse_args(["-h"])

    args = parser.parse_args(argv)

    exit_code = execute(args)
    return exit_code


if __name__ == "__main__":

    try:
        sys.exit(main())

    except Exception as e:
        e_type = str(type(e)).split(".")[-1][:-2]
        sys.stderr.write(
            "{0}: {1}\n".format(e_type, e.message))
        sys.exit(1)

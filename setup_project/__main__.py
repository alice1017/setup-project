#!/usr/bin/env python
# coding: utf-8

import sys

from .cli import parser
from .core import execute_script
from .utils import ScriptManager


def program(args):

    manager = ScriptManager()

    if args.formula_list:

        print "Formulas:"

        for key in manager.data_cache:
            print "  * {0}".format(key)

        sys.exit(0)

    script_path = manager.get_script(args.formula)
    execute_script(script_path, args.project)

    return 0


def build(argv):

    # under develop:
    # python -m setup-project => argv 2
    argv = argv[1:]

    if len(argv) == 0:
        parser.parse_args(["-h"])

    args = parser.parse_args(argv)

    exit_code = program(args)
    return exit_code


def main(argv=sys.argv):

    try:
        sys.exit(build(argv))

    except Exception as e:
        e_type = str(type(e)).split(".")[-1][:-2]
        sys.stderr.write(
            "{0}: {1}\n".format(e_type, e.message))
        sys.exit(1)


if __name__ == "__main__":

    main()

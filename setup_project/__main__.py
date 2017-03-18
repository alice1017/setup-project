#!/usr/bin/env python
# coding: utf-8

import sys
import traceback

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


def main(argv=sys.argv):

    # under develop:
    # python -m setup-project => argv 2
    argv = argv[1:]

    if len(argv) == 0:
        parser.parse_args(["-h"])

    args = parser.parse_args(argv)

    try:
        exit_code = program(args)
        sys.exit(exit_code)

    except Exception as e:
        e_type = str(type(e)).split(".")[-1][:-2]
        stack_trace = traceback.format_exc()

        if args.stacktrace:
            print "{:=^30}".format(" STACK TRACE ")
            print stack_trace.strip()

        else:
            sys.stderr.write(
                "{0}: {1}\n".format(e_type, e.message))
            sys.exit(1)

if __name__ == "__main__":

    main()

#!/usr/bin/env python
# coding: utf-8

from subprocess import call


def execute_script(script_path, project_name):

    cmd = [script_path, project_name]
    args = {"shell": True}

    call(cmd)

    return 0

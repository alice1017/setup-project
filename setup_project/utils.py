#!/usr/bin/env python
# coding: utf-8

import os

DEFAULT_SCRIPT_DIR = os.path.join(os.environ["HOME"], ".setup-project/bin")


class FormulaError(Exception):
    pass


class ScriptManager(object):

    def __init__(self, script_dir=DEFAULT_SCRIPT_DIR):

        self.script_dir = script_dir
        self.script_files = os.listdir(self.script_dir)
        self.data_cache = {}

        for script_file in self.script_files:

            formula = self.__get_formula_from_script(script_file)
            script_path = os.path.join(self.script_dir, script_file)

            self.data_cache[formula] = script_path

        return

    # PUBLIC
    def get_script(self, formula):

        for key in self.data_cache:
            if formula == key:
                return self.data_cache[key]

        raise FormulaError("Formula does not found.")

    # PRIVATE
    def __get_formula_from_script(self, script_file):

        return script_file.split("-")[1]

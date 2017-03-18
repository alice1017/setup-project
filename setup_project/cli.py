#!/usr/bin/env python
# coding: utf-8

from argparse import ArgumentParser


parser = ArgumentParser(
    prog="setup-script",
    description="The setup-project setup your project directory.")

parser.add_argument(
    "formula",
    action="store",
    help="The formula defines the structure of project directory,"
         "and configures the project license, template, and so on.")

parser.add_argument(
    "project",
    action="store",
    help="The project name")

parser.add_argument(
    "-l", "--list",
    action="store_true",
    dest="formula_list",
    help="Display project formula list.")

parser.add_argument(
    "--stack-trace",
    dest="stacktrace",
    action="store_true",
    help="Display the stack trace when error occured.")

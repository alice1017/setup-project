#!/usr/bin/env python
# coding: utf-8

from argparse import ArgumentParser, SUPPRESS


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
    "-f", "--formula-path",
    action="store",
    dest="formula_path",
    metavar="PATH",
    help="You can set your original formula. please write formula path.")

parser.add_argument(
    "-d", "--under-develop",
    action="store_true",
    dest="develop",
    default=True,
    help=SUPPRESS)

parser.add_argument(
    "-l", "--list",
    action="store_true",
    dest="formula_list",
    help="Display project formula list.")

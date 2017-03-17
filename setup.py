#!/usr/bin/env python
# coding: utf-8

from setuptools import setup
from setup_project import __author__, __version__

with open("LICENSE", "r") as fp:
    license_msg = fp.read()

setup(
    name="setup-project",
    description="Setup project directory: "
                "create files and directories by shellscript.",
    author=__author__,
    version=__version__,
    license=license_msg,
    packages=["setup_project"],
    entry_points={
        "console_scripts": [
            "setup-project=setup_project.__main__.main"
        ]
    },
    classifiers=[
        "Development Status :: 2 - Pre-Alpha",
        "Environment :: Console",
        "Intended Audience :: Developers",
        "Operating System :: Unix",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: POSIX :: Linux",
        "Programming Language :: Python",
        "Programming Language :: Python :: 2",
        "Programming Language :: Python :: 2.7",
        "License :: OSI Approved :: MIT License"
    ]
)

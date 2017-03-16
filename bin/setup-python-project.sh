#!/bin/sh
# coding: utf-8

# 0. load environs
. $HOME/.setup-project/lib/environs.sh
. $LIBDIR/functions.sh

project=$1

# 1. check argument
check_result=`check_project $project`

if [ $check_result = 1 ]; then
    echo "usage: setup-python-project.sh [project-name]"
    exit $ERROR

elif [ $check_result = 2 ]; then
    echo "error: project directory is already exist."
    exit $ERROR_EXIST
fi


# 3. make & move proj dir
mkdir $project
cd $project

# 4. git init
git init > $ECHO_OFF

# 5. generate gitignore
curl -s "https://www.gitignore.io/api/vim,python" > .gitignore
git add .gitignore
git commit -m "First commit: generate gitignore by gitignore.io" > $ECHO_OFF

# 6. generate license
licgen mit "Hayato Tominaga" > $ECHO_OFF
git add LICENSE
git commit -m "License: MIT" > $ECHO_OFF


# 7. create directories
mkdir $project
mkdir tests

# 8. create python script files
cat $TEMPLATEDIR/python.py > $project/__init__.py
cat $TEMPLATEDIR/python.py > $project/__main__.py

# 9. create other files with templates

# 9.1. Readme
touch README.md

# 9.2. testrunner.py
cat $TEMPLATEDIR/testrunner.py > testrunner.py

# 9.3. setup.py
cat $TEMPLATEDIR/setup.py > setup.py

exit $EXIT

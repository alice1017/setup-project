#!/bin/sh
# coding: utf-8

# 0. load environs
. $HOME/.setup-project/lib/environs.sh
. $LIBDIR/functions.sh

if [ ! -f $ETCDIR/settings.conf ]; then
    echo "error: There is not 'settings.conf' file."
    echo "Please exec this command, and edit settings.conf."
    echo "'cp ~/.setup-project/etc/settings.conf.sample ~/.setup-project/etc/settings.conf'"
    exit $ERROR

else
    . $ETCDIR/settings.conf

fi

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
echo_off 'git init'

# 5. generate gitignore
curl -s "https://www.gitignore.io/api/vim,python" > .gitignore
git add .gitignore
echo_off 'git commit -m "First commit: generate gitignore by gitignore.io"'

# 6. generate license
echo_off 'licgen mit "Hayato Tominaga"'
git add LICENSE
echo_off 'git commit -m "License: MIT"'


# 7. create directories
replaced_prj=`replace_hyphen $project`
mkdir $replaced_prj
mkdir tests

# 8. create python script files
cat $TEMPLATEDIR/python.py > $replaced_prj/__init__.py
cat $TEMPLATEDIR/python.py > $replaced_prj/__main__.py

# 9. create other files with templates

# 9.1. Readme
touch README.md

# 9.2. testrunner.py
cat $TEMPLATEDIR/testrunner.py > testrunner.py

# 9.3. setup.py
cat $TEMPLATEDIR/setup.py > setup.py

exit $EXIT

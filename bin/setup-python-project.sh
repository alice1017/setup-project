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
if [ $GIT = true ]; then
    echo_off 'git init'

    # 5. generate gitignore
    api_url="https://www.gitignore.io/api/${EDITOR},python"
    curl -s $api_url > .gitignore
    git add .gitignore
    echo_off 'git commit -m "First commit: generate gitignore by gitignore.io"'

fi

# 6. generate license
echo_off 'licgen ${LICENSE} "${NAME}"'

if [ $GIT = true ]; then
    git add LICENSE
    echo_off 'git commit -m "License: ${LICENSE}"'
fi


# 7. create directories
replaced_prj=`replace_hyphen $project`
mkdir $replaced_prj
mkdir tests

# 8. create python script files
cat $TEMPLATEDIR/python/python.py > $replaced_prj/__init__.py
cat $TEMPLATEDIR/python/python.py > $replaced_prj/__main__.py

# 9. create other files with templates

# 9.1. Readme
touch README.md

# 9.2. testrunner.py
cat $TEMPLATEDIR/python/testrunner.py > testrunner.py

# 9.3. setup.py
cat $TEMPLATEDIR/python/setup.py > setup.py

exit $EXIT

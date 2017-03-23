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

# 8. create files & dirs in project module

mkdir $replaced_prj/module
mkdir $replaced_prj/templates
mkfit $replaced_prj/templates/module
mkdir $replaced_prj/static

cat $TEMPLATEDIR/python.py > $replaced_prj/__init__.py
cat $TEMPLATEDIR/python.py > $replaced_prj/module/__init__.py
cat $TEMPLATEDIR/python.py > $replaced_prj/module/controllers.py
cat $TEMPLATEDIR/python.py > $replaced_prj/module/models.py

# 9. create python scripts

cat $TEMPLATEDIR/python.py > $replaced_prj/runserver.py
cat $TEMPLATEDIR/python.py > $replaced_prj/config.py

exit $EXIT

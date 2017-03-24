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

# 7. create app directory
mkdir app

# 8. create files & dirs in application
mkdir app/templates
mkdir app/static
mkdir tests

cat $TEMPLATEDIR/python-flask/app_init.py > app/__init__.py
cat $TEMPLATEDIR/python/python.py > app/controllers.py
cat $TEMPLATEDIR/python/python.py > app/models.py
cat $TEMPLATEDIR/python-flask/views.py > app/views.py

# 9. create python scripts

cat $TEMPLATEDIR/python-flask/runserver.py > runserver.py
cat $TEMPLATEDIR/python/testrunner.py > testrunner.py

exit $EXIT

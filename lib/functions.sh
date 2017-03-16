#!/bin/sh
# coding: utf-8

check_project () {
    project=$1

    # 1. check argument
    if [ "$project" = "" ]; then
        echo 1
        return 0
    fi

    # 2. check already exist proj dir
    if [ -d $project ]; then
        echo 2
        return 0
    fi

    echo 0
    return 0
}

replace_hyphen () {

    echo `echo $1 | sed s/-/_/g`

}


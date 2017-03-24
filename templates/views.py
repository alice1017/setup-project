#!/usr/bin/env python
# coding: utf-8

from flask import Blueprint

app_view = Blueprint("view", __name__, template_folder="templates")


@app_view.route("/")
def TopView():
    return "<h1>It works!</h1>"

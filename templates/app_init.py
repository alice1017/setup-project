#!/usr/bin/env python
# coding: utf-8

from flask import Flask

from .views import app_view

app = Flask(__name__)
app.debug = True
app.register_blueprint(app_view)

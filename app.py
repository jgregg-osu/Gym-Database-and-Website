from flask import Flask, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os

app = Flask(__name__)
mysql = MySQL(app)


# Routes
@app.route('/')
def index():
    return render_template('index.html')


# Listener
if __name__ == "__main__":

    #Start the app on port 3000, it will be different once hosted
    app.run(port=2489, debug=True)
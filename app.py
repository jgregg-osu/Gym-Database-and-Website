from flask import Flask, render_template, json
import database.db_connector as db
import os

# Configuration

app = Flask(__name__)

db_connection = db.connect_to_database()

# Routes 

@app.route('/')
def root():
    return render_template('index.j2')

@app.route('/members')
def members():
    query = "SELECT * from Members;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template('members.j2', members=results)

@app.route('/gyms')
def gyms():
    query = "SELECT * from Gyms;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template('gyms.j2', gyms=results)





# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 9111)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True)
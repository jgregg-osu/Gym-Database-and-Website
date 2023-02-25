from flask import Flask, render_template, json, redirect
from flask import request
from flask_mysqldb import MySQL
import database.db_connector as db
from dotenv import load_dotenv, find_dotenv
import os


# Configuration

app = Flask(__name__)

#database connection
#db_connection = db.connect_to_database()
load_dotenv(find_dotenv())

app.config["MYSQL_HOST"] = os.environ.get("340DBHOST")
app.config["MYSQL_USER"] = os.environ.get("340DBUSER")
app.config["MYSQL_PASSWORD"] = os.environ.get("340DBPW")
app.config["MYSQL_DB"] = os.environ.get("340DBUSER")
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

mysql = MySQL(app)

# Routes 
@app.route('/')
def root():
    return render_template('index.j2')

@app.route('/members', methods=["POST", "GET"])
def members():
    if request.method == "POST":
        # fire off if user presses the Add Member button
        if request.form.get("addMember"):
            # grab user form inputs
            f_name = request.form["f_name"]
            l_name = request.form["l_name"]
            address = request.form["address"]
            birthday = request.form["birthday"]
            plan_id = request.form["plan_id"]
            gym_id = request.form["gym_id"]

            # account for cases where gym_id is set to null
            if gym_id == "0":
                query = "INSERT INTO Members (f_name, l_name, address, birthday, plan_id) VALUES (%s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query,(f_name, l_name, address, birthday, plan_id))
                mysql.connection.commit()

            else:
                query = "INSERT INTO Members (f_name, l_name, address, birthday, plan_id, gym_id) VALUES (%s, %s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query,(f_name, l_name, address, birthday, plan_id, gym_id))
                mysql.connection.commit()

            return redirect("/members")
        
    if request.method == "GET":
        # mySQL query to grab all the members in Members
        query1 = "SELECT Members.member_id AS 'Member_ID', \
            Members.f_name AS 'First_Name', \
            Members.l_name AS 'Last_Name', \
            Members.address AS Address, \
            Members.birthday AS Birthday, \
            Members.plan_id AS 'Membership_Plan_ID', \
            Members.gym_id AS 'Gym_ID' \
        FROM Members;"
        cur = mysql.connection.cursor()
        cur.execute(query1)
        data = cur.fetchall()
    
        #mySQL query to grab plan_id for dropdown
        query2 = "SELECT Plans.plan_id FROM Plans;"
        cur = mysql.connection.cursor()
        cur.execute(query2)
        plan_data = cur.fetchall()
        
        #mySQL query to grab gym_id for dropdown
        query3 = "Select Gyms.gym_id FROM Gyms;"
        cur = mysql.connection.cursor()
        cur.execute(query3)
        gym_data = cur.fetchall()

        return render_template('members.j2', data=data, plans=plan_data, gyms=gym_data)
    
    
@app.route("/delete_member/<int:Member_ID>")
def delete_member(Member_ID):
    #mySQL query to delete the member with our passed id
    query = "DELETE FROM Members WHERE Member_ID = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (Member_ID,))
    mysql.connection.commit()
    return redirect('/members')

@app.route("/edit_member/<int:Member_ID>", methods=["POST", "GET"])
def edit_member(Member_ID):
    if request.method == "GET":
        # mySQL query to grab the infor of the person with our passed id
        query = "SELECT Members.member_id AS 'Member_ID', \
            Members.f_name AS 'First_Name', \
            Members.l_name AS 'Last_Name', \
            Members.address AS Address, \
            Members.birthday AS Birthday, \
            Members.plan_id AS 'Membership_Plan_ID', \
            Members.gym_id AS 'Gym_ID' \
        FROM Members WHERE Member_ID = %s" % (Member_ID)
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        #mySQL query to grab plan_id for dropdown
        query2 = "SELECT Plans.plan_id FROM Plans;"
        cur = mysql.connection.cursor()
        cur.execute(query2)
        plan_data = cur.fetchall()
        
    
        #mySQL query to grab gym_id for dropdown
        query3 = "Select Gyms.gym_id FROM Gyms;"
        cur = mysql.connection.cursor()
        cur.execute(query3)
        gym_data = cur.fetchall()

        return render_template('edit_member.j2', data=data, plans=plan_data, gyms=gym_data)
    
    if request.method == "POST":
        # fire off if user clicks the "Edit Person" button
        if request.form.get("Edit_Member"):
            # grab user form inputs
            f_name = request.form["f_name"]
            l_name = request.form["l_name"]
            address = request.form["address"]
            birthday = request.form["birthday"]
            plan_id = request.form["plan_id"]
            gym_id = request.form["gym_id"]

            # account for cases where gym_id is set to null
            if gym_id == "0":
                query = "INSERT INTO Members (f_name, l_name, address, birthday, plan_id) VALUES (%s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query,(f_name, l_name, address, birthday, plan_id))
                mysql.connection.commit()

            else:
                query = "INSERT INTO Members (f_name, l_name, address, birthday, plan_id, gym_id) VALUES (%s, %s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query,(f_name, l_name, address, birthday, plan_id, gym_id))
                mysql.connection.commit()

            return redirect("/members")
            

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 9111)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=9111, debug=True)
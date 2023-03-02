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

# return to index page 
@app.route('/')
def root():
    return render_template('index.j2')


'''####################################################################################################################
Members Routes
Includes Browse, Add, Update, and Delete Functionality
####################################################################################################################'''
# route to members page
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
    
# handle deletion of members
@app.route("/delete_member/<int:Member_ID>")
def delete_member(Member_ID):
    #mySQL query to delete the member with our passed id
    query = "DELETE FROM Members WHERE Member_ID = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (Member_ID,))
    mysql.connection.commit()
    return redirect('/members')

# handle editing members
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
            member_id = request.form["member_id"]
            f_name = request.form["f_name"]
            l_name = request.form["l_name"]
            address = request.form["address"]
            birthday = request.form["birthday"]
            plan_id = request.form["plan_id"]
            gym_id = request.form["gym_id"]

            # account for cases where gym_id is set to null
            if gym_id == "0":
                query = "UPDATE Members \
                    SET Members.f_name = %s, \
                        Members.l_name = %s,\
                        Members.address = %s,\
                        Members.birthday = %s,\
                        Members.plan_id = %s,\
                        Members.gym_id = NULL\
                    WHERE Members.member_id = %s"
                cur = mysql.connection.cursor()
                cur.execute(query,(f_name, l_name, address, birthday, plan_id, member_id))
                mysql.connection.commit()

            else:
                query = "UPDATE Members \
                    SET Members.f_name = %s, \
                        Members.l_name = %s,\
                        Members.address = %s,\
                        Members.birthday = %s,\
                        Members.plan_id = %s,\
                        Members.gym_id = %s\
                    WHERE Members.member_id = %s"
                cur = mysql.connection.cursor()
                cur.execute(query,(f_name, l_name, address, birthday, plan_id, gym_id, member_id))
                mysql.connection.commit()

            return redirect("/members")


'''####################################################################################################################
Plans Routes
Includes Browse, Add, and Delete Functionality
####################################################################################################################'''
@app.route("/plans", methods=["GET", "POST"])
def plans():
    if request.method == "GET":
        query = "SELECT Plans.plan_id AS 'Membership_Plan_ID', \
                Plans.monthly_fee AS 'Monthly Fee', \
                Plans.weight_cardio AS 'Weights/Cardio', \
                Plans.spa_room AS 'Spa Room', \
                Plans.lap_pool AS 'Lap Pool', \
                Plans.ballcourt AS 'Ballcourt' \
                FROM Plans"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        return render_template("plans.j2", data = data)

    if request.method == "POST":
        #activates when adding a new plan.
        if request.form.get("addPlan"):
            # grab user form inputs
            monthly_fee = request.form["monthly_fee"]
            weight_cardio = request.form["weight_cardio"]
            spa_room = request.form["spa_room"]
            lap_pool = request.form["lap_pool"]
            ballcourt = request.form["ballcourt"]

            query = "INSERT INTO Plans(monthly_fee, weight_cardio, spa_room, lap_pool, ballcourt) \
                    VALUES (%s, %s, %s, %s, %s)"
            cursor = mysql.connection.cursor()
            cursor.execute(query,(monthly_fee, weight_cardio, spa_room, lap_pool, ballcourt))
            mysql.connection.commit()

            return redirect("/plans")


# handle deletion of members
@app.route("/delete_plan/<int:plan_id>")
def delete_plan(plan_id):
    #mySQL query to delete the member with our passed id
    query = "DELETE FROM Plans WHERE plan_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (plan_id,))
    mysql.connection.commit()

    return redirect('/plans')


# handle editing plans
# @app.route("/edit_plan/<int:plan_id>", methods=["GET", "POST"])
# def edit_plan(plan_id):


'''####################################################################################################################
Gyms Routes
Includes No Functionality
####################################################################################################################'''
@app.route("/gyms", methods=["GET", "POST"])
def gyms():
    if request.method == "GET":
        query = "SELECT Gyms.gym_id AS 'Gym_ID', \
        Gyms.gym_address AS Address, \
        Gyms.opening_time AS OPENS, \
        Gyms.closing_time AS CLOSES \
        FROM Gyms"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        return render_template("gyms.j2", data = data)

    if request.method == "POST":
        #activates when adding a new plan.
        if request.form.get("addGym"):
            # grab user form inputs
            gym_address = request.form["gym_address"]
            opening_time = request.form["opening_time"]
            closing_time = request.form["closing_time"]

            query = "INSERT INTO Gyms(gym_address, opening_time, closing_time) \
                    VALUES (%s, %s, %s)"
            cursor = mysql.connection.cursor()
            cursor.execute(query,(gym_address, opening_time, closing_time))
            mysql.connection.commit()

            return redirect("/gyms")


# handle deletion of gyms
@app.route("/delete_gym/<int:gym_id>")
def delete_gym(gym_id):
    #mySQL query to delete the member with our passed id
    query = "DELETE FROM Gyms WHERE gym_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (gym_id,))
    mysql.connection.commit()

    return redirect('/gyms')


'''####################################################################################################################
Instructors Routes
Includes No Functionality
####################################################################################################################'''
@app.route("/instructors", methods=["POST", "GET"])
def instructors():
    if request.method == "GET":
        query = "SELECT Instructors.instructor_id AS 'Instructor_ID', \
                    Instructors.f_name AS 'First_Name', \
                    Instructors.l_name AS 'Last_Name', \
                    Instructors.address AS Address, \
                    Instructors.birthday AS Birthday, \
                    Instructors.email AS Email, \
                    Instructors.phone_number AS 'Phone_Number', \
                    Instructors.gym_id AS 'Gym_ID'\
                FROM Instructors"

        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        query2 = "SELECT Gyms.gym_id FROM Gyms"
        cur = mysql.connection.cursor()
        cur.execute(query2)
        gym_data = cur.fetchall()
        
        return render_template('instructors.j2', data=data, gyms=gym_data)
    
    if request.method == "POST":
        # fire off if user presses the Add Instructor button
        if request.form.get("addInstructor"):
            # grab user form inputs
            f_name = request.form["f_name"]
            l_name = request.form["l_name"]
            address = request.form["address"]
            birthday = request.form["birthday"]
            email = request.form["email"]
            phone_number = request.form["phone_number"]
            gym_id = request.form["gym_id"]

            # account for cases where gym_id is set to null
            if gym_id == "0":
                query = "INSERT INTO Instructors (f_name, l_name, address, birthday, email, phone_number) VALUES (%s, %s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query,(f_name, l_name, address, birthday, email, phone_number))
                mysql.connection.commit()

            else:
                query = "INSERT INTO Instructors (f_name, l_name, address, birthday, email, phone_number, gym_id) VALUES (%s, %s, %s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query,(f_name, l_name, address, birthday, email, phone_number, gym_id))
                mysql.connection.commit()

            return redirect("/instructors")
        
# handle deletion of instructors
@app.route("/delete_instructor/<int:Instructor_ID>")
def delete_instructor(Instructor_ID):
    #mySQL query to delete the member with our passed id
    query = "DELETE FROM Instructors WHERE Instructor_ID = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (Instructor_ID,))
    mysql.connection.commit()
    return redirect('/instructors')
            


'''####################################################################################################################
Classes Routes
Includes No Functionality
####################################################################################################################'''
@app.route("/classes", methods=["POST", "GET"])
def classes():
    if request.method == "GET":
        query = "SELECT Classes.class_id AS 'Class_ID',\
                    Classes.class_type AS 'Class_Type', \
                    Classes.schedule AS 'Schedule',\
                    Classes.duration AS 'Duration',\
                    Instructors.instructor_id AS 'Instructor_ID',\
                    CONCAT(Instructors.f_name, ' ',Instructors.l_name) AS Instructor_Name\
                FROM Classes \
                INNER JOIN Instructors ON Classes.instructor_id = Instructors.instructor_id"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        query2 = "SELECT Instructors.f_name, Instructors.instructor_id FROM Instructors"
        cur = mysql.connection.cursor()
        cur.execute(query2)
        instructor_data = cur.fetchall()
        return render_template('classes.j2', data=data, instructors = instructor_data)
    
    if request.method == "POST":
        if request.form.get("addClass"):
            class_type = request.form["class_type"]
            duration = request.form["duration"]
            instructor_id  = request.form["instructor_id"]
            schedule = request.form["schedule"]


            query = "INSERT INTO Classes(class_type, duration, instructor_id, schedule) VALUES (%s, %s, %s, %s)"
            cursor = mysql.connection.cursor()
            cursor.execute(query,(class_type, duration, instructor_id, schedule))
            mysql.connection.commit()

            return redirect("/classes")
        
@app.route("/edit_class/<int:Class_ID>", methods=["POST", "GET"])
def edit_class(Class_ID):
    if request.method == "GET":
        # mySQL query to grab the infor of the person with our passed id
        query = "SELECT Classes.class_id AS 'Class_ID',\
                    Classes.class_type AS 'Class_Type', \
                    Classes.schedule AS 'Schedule',\
                    Classes.duration AS 'Duration',\
                    Instructors.instructor_id AS 'Instructor_ID',\
                    CONCAT(Instructors.f_name, ' ',Instructors.l_name) AS Instructor_Name\
                FROM Classes \
                INNER JOIN Instructors ON Classes.instructor_id = Instructors.instructor_id\
                WHERE Class_ID = %s" % (Class_ID)
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()

        #mySQL query to grab plan_id for dropdown
        query2 = "SELECT Instructors.f_name, Instructors.instructor_id FROM Instructors"
        cur = mysql.connection.cursor()
        cur.execute(query2)
        instructor_data = cur.fetchall()
        
        return render_template('edit_class.j2', data=data, instructors = instructor_data)    

    if request.form.get("Edit_Class"):
            # grab user form inputs
            class_id = request.form["class_id"]
            class_type = request.form["class_type"]
            schedule = request.form["schedule"]
            duration = request.form["duration"]
            instructor_id = request.form["instructor_id"]

            query = "UPDATE Classes \
                SET Classes.class_type = %s, \
                    Classes.schedule = %s,\
                    Classes.duration = %s,\
                    Classes.instructor_id = %s\
                WHERE Classes.class_id = %s"
            cur = mysql.connection.cursor()
            cur.execute(query,(class_type, schedule, duration, instructor_id, class_id))
            mysql.connection.commit()
            return redirect("/classes")    
    
# handle deletion of classes
@app.route("/delete_class/<int:Class_ID>")
def delete_class(Class_ID):
    query = "DELETE FROM Classes WHERE Class_ID = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (Class_ID,))
    mysql.connection.commit()
    return redirect('/classes')



'''####################################################################################################################
Class Participants Routes
Includes No Functionality
####################################################################################################################'''
@app.route("/class_participants", methods=["Get", "Post"])  
def class_participants():
    if request.method == "GET":
        query = "SELECT  Class_participants.member_class_id AS 'Class Particpant ID', \
                Members.member_id AS 'Member ID', \
                CONCAT(Members.f_name, " ",Members.l_name) AS 'Member Name' \
                Class_participants.class_id AS 'Class ID', \
                Classes.class_type AS 'Class Type', \
                Classes.schedule AS 'Schedule', \
        FROM Members \
        JOIN Members ON Members.member_id = Class_participants.member_id \
        JOIN Classes ON Class_participants.class_id = Classes.class_id"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        return render_template("class_participants.j2", data = data)
    
    if request.method == "POST":
        if request.form.get("addParticipant"):
            member_class_id = request.form["member_id"]
            workout_class_id = request.form["workout_class_id"]
            query = "INSERT INTO Class_participants(class_id, member_id) VALUES  (%s, %s)"
            cursor = mysql.connection.cursor()
            cursor.execute(query,(member_class_id, workout_class_id))
            mysql.connection.commit()

            return redirect("/class_participants")

# handle deletion of class_participants
@app.route("/delete_class_participants/<int:member_class_ID>")
def delete_class_participants(member_class_ID):
    query = "DELETE FROM Class_participants WHERE member_class_ID = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (member_class_ID,))
    mysql.connection.commit()
    return redirect('/class_participants')



# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 4000)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=4000, debug=True)
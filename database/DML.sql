------------------------------------------------------------------------------
-- Members queries --
------------------------------------------------------------------------------
-- select all Members --
SELECT  Members.member_id AS "Member ID",
        Members.f_name AS "First_Name",
        Members.l_name AS "Last_Name",
        Members.address AS Address,
        Members.birthday AS Birthday,
        Members.plan_id AS "Membership_Plan_ID",
        Members.gym_id AS "Gym_ID"
FROM Members 

-- grab Plans.plan_id for dropdown --
SELECT Plans.plan_id FROM Plans

-- grab Gyms.gym_id for dropdown --
Select Gyms.gym_id FROM Gyms

-- add new Member --
INSERT INTO Members(f_name, l_name, address, birthday, plan_id, gym_id)
VALUES (:f_nameInput,
        :l_nameInput,
        :addressInput,
        :birthdayInput,
        :plan_idInput,
        :gym_idInput)

-- browse member data for edit page --
SELECT  Members.member_id AS "Member ID",
        Members.f_name AS "First_Name",
        Members.l_name AS "Last_Name",
        Members.address AS Address,
        Members.birthday AS Birthday,
        Members.plan_id AS "Membership_Plan_ID",
        Members.gym_id AS "Gym_ID"
FROM Members WHERE member_id = :member_id_selected_from_browse_member_page

-- update member data --
UPDATE Members
SET Members.f_name = :new_first_name,
    Members.l_name = :new_last_name,
    Members.address = :new_address,
    Members.birthday = :new_birthday,
    Members.plan_id = :new_plan_id,
    Members.gym_id = :new_gym
WHERE Members.member_id = :id_from_form

-- Delete member --
DELETE FROM Members
WHERE member_id = :id_from_form



------------------------------------------------------------------------------
-- Instructors queries --
------------------------------------------------------------------------------
-- select all Instructors --
SELECT  Instructors.instructor_id AS "Instructor_ID", 
        Instructors.f_name AS "First_Name", 
        Instructors.l_name AS "Last_Name", 
        Instructors.address AS Address, 
        Instructors.birthday AS Birthday, 
        Instructors.email AS Email, 
        Instructors.phone_number AS "Phone_Number", 
        Instructors.gym_id AS "Gym_ID"
FROM Instructors 

-- grab Gyms.gym_id for dropdown --
SELECT Gyms.gym_id FROM Gyms

-- add new Instructor --
INSERT INTO Instructors(f_name, l_name, address, birthday, email, phone_number, gym_id)
VALUES (:f_nameInput,
        :l_nameInput,
        :addressInput,
        :birthdayInput,
        :emailInput,
        :phoneInput,
        :gym_idInput)

-- browse Instructors data for edit page --
SELECT  Instructors.instructor_id AS "Instructor_ID", 
        Instructors.f_name AS "First_Name", 
        Instructors.l_name AS "Last_Name", 
        Instructors.address AS Address, 
        Instructors.birthday AS Birthday, 
        Instructors.email AS Email, 
        Instructors.phone_number AS "Phone_Number", 
        Instructors.gym_id AS "Gym_ID"
FROM Instructors WHERE instructor_id = :instructor_id_selected_from_browse_instructor_page

-- update Instructor --
UPDATE FROM Instructors
SET f_name = :new_first_name
    l_name = :new_last_name
    address = :new_address
    birthday = :new_birthday
    email = :new_email
    phone_number = :new_phone_number
    gym_id = :new_gym_id
WHERE instructor_id = :id_from_form

-- delete Instructor --
DELETE FROM Instructors
WHERE instructor_id = :id_from_form



------------------------------------------------------------------------------
-- Gyms queries --
------------------------------------------------------------------------------
-- select all gyms --
SELECT Gyms.gym_id AS "Gym_ID", 
        Gyms.gym_address AS Address,
        Gyms.opening_time AS OPENS
        Gyms.closing_time AS CLOSES
FROM Gyms

-- add new gym --
INSERT INTO Gyms(gym_address, opening_time, closing_time)
VALUES (:gym_addressInput, :opening_timeInput, :closing_timeInput)

-- browse Gym data for edit page --
SELECT  Gyms.gym_id AS "Gym_ID", 
        Gyms.gym_address AS Address,
        Gyms.opening_time AS OPENS
        Gyms.closing_time AS CLOSES
FROM Gyms WHERE gym_id = :gym_id_selected_from_browse_gym_page

-- update gym information --
UPDATE Gyms
SET gym_address = :new_gym_address
    opening_time = :new_opening_time
    closing_time = :new_closing_time
WHERE gym_id = :id_from_form

-- delete gym --
DELETE FROM Gyms
WHERE gym_id = :id_from_form



------------------------------------------------------------------------------
-- Plan queries --
------------------------------------------------------------------------------
-- select all membership plans --
SELECT Plans.plan_id AS "Membership_Plan_ID", 
        Plans.monthly_fee AS "Monthly Fee",
        Plans.weight_cardio AS "Weights/Cardio",
        Plans.spa_room AS "Spa Room",
        Plans.lap_pool AS "Lap Pool",
        Plans.ballcourt AS Ballcourt
FROM Plans

-- add new membership plan --
INSERT INTO Plans(monthly_fee, weight_cardio, spa_room, lap_pool, ballcourt)
VALUES (:monthly_feeInput,
        :weight_cardioInput,
        :spa_roomInput,
        :lap_poolInput,
        :ballcourtInput)

-- browse Plans data for edit Plans page -- 
SELECT  Plans.plan_id AS "Membership_Plan_ID", 
        Plans.monthly_fee AS "Monthly Fee",
        Plans.weight_cardio AS "Weights/Cardio",
        Plans.spa_room AS "Spa Room",
        Plans.lap_pool AS "Lap Pool",
        Plans.ballcourt AS Ballcourt
FROM Plans Where plan_id = :plan_id_selected_from_browse_plan_page

-- update membership plan --
UPDATE Plans
SET monthly_fee = :new_monthly_fee
    weight_cardio = :new_weight_cardio
    spa_room = :new_spa_room
    lap_pool = :new_lap_pool
    ballcourt = :new_ballcourt
WHERE plan_id = :id_from_form

-- delete membership plan --
DELETE FROM Plans
WHERE plan_id = :id_from_form



------------------------------------------------------------------------------
-- Workout classes queries --
------------------------------------------------------------------------------
-- select all workout classes --
SELECT  Classes.class_id AS "Class_ID", 
        Classes.class_type AS "Class_Type", 
        Classes.schedule AS Schedule,
        Classes.duration AS Duration,
        Instructors.instructor_id AS "Instructor ID",
        CONCAT(Instructors.f_name, ' ', Instructors.l_name ) AS "Instructor_Name"
FROM Classes
INNER JOIN Instructors ON Classes.instructor_id = Instructors.instructor_id

-- grab Instructors info for dropdown --
SELECT Instructors.f_name, Instructors.instructor_id FROM Instructors

-- select workout classes for specific Instructor --
SELECT  Classes.class_id, 
        Classes.class_type, 
        Classes.schedule,
        Classes.duration,
FROM Classes WHERE Classes.instructor_id = :id_from_form

-- add new workout class --
INSERT INTO Classes(class_type, duration, instructor_id, schedule)
VALUES (:class_typeInput, :durationInput, :instructor_idInput, :scheduleInput)

-- select classes data for edit page -- 
SELECT  Classes.class_id AS "Class_ID", 
        Classes.class_type AS "Class_Type", 
        Classes.schedule AS Schedule,
        Classes.duration AS Duration,
        Instructors.instructor_id AS "Instructor ID",
        CONCAT(Instructors.f_name, ' ', Instructors.l_name ) AS "Instructor_Name"
FROM Classes WHERE class_id = :class_id_selected_from_browse_plan_page

-- update workout class --
UPDATE Classes
SET class_type = :new_class_type
    schedule = :new_schedule
    duration = :new_duration
    instructor_id = :new_instructor_id
WHERE class_id = :id_from_form

-- delete workout class --
DELETE FROM Classes
WHERE class_id = :id_from_form



------------------------------------------------------------------------------
-- Class Participants queries --
------------------------------------------------------------------------------
-- select all Class Participants --
SELECT  Class_participants.member_class_id AS 'Class_Participant_ID', 
        Members.member_id AS 'Member_ID', 
        CONCAT(Members.f_name, ' ',Members.l_name) AS 'Member Name', 
        Class_participants.class_id AS 'Class_ID', 
        Classes.class_type AS 'Class Type', 
        Classes.schedule AS 'Schedule' 
FROM Class_participants 
JOIN Members ON Members.member_id = Class_participants.member_id 
JOIN Classes ON Class_participants.class_id = Classes.class_id;

-- grab Members.member_id for dropdown --
SELECT Members.member_id,
    CONCAT(Members.f_name, ' ', Members.l_name) as Name
FROM Members;

-- grab classes for dropdown --
Select Classes.class_id,
        CONCAT(Classes.class_type, ' ', Classes.schedule) AS Class 
FROM Classes;

-- add new Class Participants --
INSERT INTO Class_participants(class_id, member_id)
VALUES  ((class_id WHERE class_type = :class_typeInput AND schedule = :scheduleInput),
        (member_id CONCAT(Members.f_name, " ", Members.l_name) = :member_name))

-- select class particpant data for edit page --
SELECT  Class_participants.member_class_id AS 'Class_Participant_ID', 
        Members.member_id AS 'Member_ID', 
        CONCAT(Members.f_name, ' ',Members.l_name) AS 'Member Name', 
        Class_participants.class_id AS 'Class_ID', 
        Classes.class_type AS 'Class Type', 
        Classes.schedule AS 'Schedule' 
FROM Class_participants 
JOIN Members ON Members.member_id = Class_participants.member_id 
JOIN Classes ON Class_participants.class_id = Classes.class_id;

-- update workout class --
UPDATE Class_participants 
                SET Class_participants.member_id = :new_member_id, 
                    Class_participants.class_id = :new_class_id 
                WHERE Class_participants.member_class_id = :class_id_from_form

-- delete Class Participant --
DELETE FROM Class_participants
WHERE Class_participants_id = :id_from_form
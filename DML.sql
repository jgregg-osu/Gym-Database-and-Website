------------------------------------------------------------------------------
-- Members queries --
------------------------------------------------------------------------------
-- select all Members --
SELECT  Members.member_id AS "Member ID",
        Members.f_name AS "First Name",
        Members.l_name AS "Last Name",
        Members.address AS Address,
        Members.birthday AS Birthday,
        Members.plan_id AS "Membership Plan ID",
        Gyms.gym_id AS "Gym ID"
FROM Members 
INNER JOIN Plans ON Members.plan_id = Plans.plan_id
LEFT JOIN Gyms ON Members.gym_id = Gyms.gym_id

-- add new Member --
INSERT INTO Members(f_name, l_name, address, birthday, plan_id, gym_id)
VALUES (:f_nameInput,
        :l_nameInput,
        :addressInput,
        :birthdayInput,
        :plan_idInput,
        :gym_idInput)

-- update member data --
SELECT  Members.member_id,
        Members.f_name,
        Members.l_name,
        Members.address,
        Members.birthday,
        Members.plan_id,
        Members.gym_id
FROM Members WHERE member_id = :member_id_selected_from_browse_member_page
UPDATE Members
SET f_name = :new_first_name,
    l_name = :new_last_name,
    address = :new_address,
    birthday = :new_birthday,
    plan_id = :new_plan_id,
    gym_id = :new_gym
WHERE member_id = :id_from_form

-- Delete member --
DELETE FROM Members
WHERE member_id = :id_from_form



------------------------------------------------------------------------------
-- Instructors queries --
------------------------------------------------------------------------------
-- select all Instructors --
SELECT  Instructors.instructor_id AS "Instructor ID", 
        Instructors.f_name AS "First Name", 
        Instructors.l_name AS "Last Name", 
        Instructors.address AS Address, 
        Instructors.birthday AS Birthday, 
        Instructors.email AS Email, 
        Instructors.phone_number AS "Phone Number", 
        Gyms.gym_id AS "Gym ID"
FROM Instructors 
LEFT JOIN Gyms ON Instructors.gym_id = Gyms.gym_id

-- add new Instructor --
INSERT INTO Instructors(f_name, l_name, address, birthday, email, phone_number, gym_id)
VALUES (:f_nameInput,
        :l_nameInput,
        :addressInput,
        :birthdayInput,
        :emailInput,
        :phoneInput,
        :gym_idInput)

-- update Instructor --
SELECT  Instructors.instructor_id,
        Instructors.f_name,
        Instructors.l_name,
        Instructors.address,
        Instructors.birthday,
        Instructors.email,
        Instructors.phone_number,
        Instructors.gym_id
FROM Instructors WHERE instructor_id = :instructor_id_selected_from_browse_instructor_page
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
SELECT Gyms.gym_id AS "Gym ID", 
        Gyms.gym_address AS Address,
        Gyms.opening_time AS OPENS
        Gyms.closing_time AS CLOSES
FROM Gyms

-- add new gym --
INSERT INTO Gyms(gym_address, opening_time, closing_time)
VALUES (:gym_addressInput, :opening_timeInput, :closing_timeInput)

-- update gym information --
SELECT  Gyms.gym_address,
        Gyms.opening_time
        Gyms.closing_time
FROM Gyms WHERE gym_id = :gym_id_selected_from_browse_gym_page
UPDATE Gyms
SET gym_address = :new_gym_address
    opening_time = :new_opening_time
    closing_time = :new_closing_time
WHERE gym_id = :id_from_form

-- delete gym --
DELETE FROM Gyms
WHERE gym_id = :id_from_form



------------------------------------------------------------------------------
-- Membership plan queries --
------------------------------------------------------------------------------
-- select all membership plans --
SELECT Plans.plan_id AS "Membership Plan ID", 
        Plans.monthly_fee AS "Monthly Fee",
        Plans.weight_cardio AS "Weights/Cardio",
        Plans.spa_room AS "Spa Room",
        Plans.lap_pool AS "Lap Pool",
        Plans.ballcourt AS Ballcourt
from Plans

-- add new membership plan --
INSERT INTO Plans(monthly_fee, weight_cardio, spa_room, lap_pool, ballcourt)
VALUES (:monthly_feeInput,
        :weight_cardioInput,
        :spa_roomInput,
        :lap_poolInput,
        :ballcourtInput)

-- update membership plan --
SELECT  Plans.monthly_fee,
        Plans.weight_cardio,
        Plans.spa_room,
        Plans.lap_pool,
        Plans.ballcourt
FROM Plans Where plan_id = :plan_id_selected_from_browse_plan_page
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
SELECT  Classes.class_id AS "Class ID", 
        Classes.class_type AS "Class Type", 
        Classes.schedule AS Schedule,
        Classes.duration AS Duration,
        Instructors.instructor_id AS "Instructor ID",
        CONCAT(Instructors.f_name, " ", Instructors.l_name ) AS "Instructor Name"
FROM Classes
INNER JOIN Instructors ON Classes.instructor_id = Instructors.instructor_id

-- select workout classes for specific Instructor --
SELECT  Classes.class_id, 
        Classes.class_type, 
        Classes.schedule,
        Classes.duration,
FROM Classes WHERE Classes.instructor_id = :id_from_form

-- add new workout class --
INSERT INTO Classes(class_type, duration, instructor_id, schedule)
VALUES (:class_typeInput, :durationInput, :instructor_idInput, :scheduleInput)

-- update workout class --
SELECT  Classes.class_type, 
        Classes.schedule,
        Classes.duration,
        Instructors.instructor_id,
FROM Classes WHERE class_id = :class_id_selected_from_browse_plan_page
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
SELECT  Class_participants.member_class_id AS "Class Particpant ID",
        Class_participants.class_id AS "Class ID",
        Classes.class_type AS "Class Type",
        Classes.schedule AS "Schedule",
        Members.member_id AS "Member ID",
        CONCAT(Members.f_name, " ",Members.l_name) AS 'Member Name'
FROM Members 
JOIN Members_classes ON Members.member_id = Members_classes.member_id
JOIN Classes ON Members_classes.class_id = Classes.class_id

-- add new Class Participants
INSERT INTO Class_participants(class_id, member_id)
VALUES  ((class_id WHERE class_type = :class_typeInput AND schedule = :scheduleInput),
        (member_id CONCAT(Members.f_name, " ", Members.l_name) = :member_name))


-- delete Class Participant
DELETE FROM Class_participants
WHERE Class_participants_id = :id_from_form

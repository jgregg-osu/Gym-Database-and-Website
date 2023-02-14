------------------------------------------------------------------------------
-- Members queries --
------------------------------------------------------------------------------
-- select all Members --
SELECT  Members.member_id,
        Members.f_name,
        Members.l_name,
        Members.address,
        Members.birthday,
        Members.plan_id,
        Gyms.gym_id
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
SELECT  Instructors.instructor_id, 
        Instructors.f_name, 
        Instructors.l_name, 
        Instructors.address, 
        Instructors.birthday, 
        Instructors.email, 
        Instructors.phone_number, 
        Gyms.gym_id
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
FROM Instructors WHERE instructor_id = :instructor_id_selected_from_browse_member_page
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
SELECT * FROM Gyms

-- add new gym --
INSERT INTO Gyms(gym_address, opening_time, closing_time)
VALUES (:gym_addressInput, :opening_timeInput, :closing_timeInput)

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
-- Membership plan queries --
------------------------------------------------------------------------------
-- select all membership plans --
SELECT * from Plans

-- add new membership plan --
INSERT INTO Plans(monthly_fee, weight_cardio, spa_room, lap_pool, ballcourt)
VALUES (:monthly_feeInput,
        :weight_cardioInput,
        :spa_roomInput,
        :lap_poolInput,
        :ballcourtInput)

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
SELECT  Classes.class_id, 
        Classes.class_type, 
        Classes.schedule,
        Classes.duration,
        Instructors.instructor_id,
        Instructors.f_name
        Instructors.l_name,
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
SELECT  Members_classes.member_class_id,
        Members_classes.class_id,
        Classes.class_type,
        Classes.schedule,
        Members.member_id,
        Members.f_name,
        Members.l_name
FROM Members 
JOIN Members_classes ON Members.member_id = Members_classes.member_id
JOIN Classes ON Members_classes.class_id = Classes.class_id

-- add new Class Participants
INSERT INTO Members_classes(class_id, member_id)
VALUES  ((class_id WHERE class_type = :class_typeInput AND schedule = :scheduleInput),
        (member_id WHERE f_name = :f_nameInput AND l_name = :l_nameInput))

-- update Class Participant
UPDATE Members_classes
SET class_type = :new_class_type
    schedule = :new_schedule
    f_name = :new_f_name
    l_name = :new_l_name
WHERE Members_classes_id = :id_from_form

-- delete Class Participant
DELETE FROM Members_classes
WHERE Members_classes_id = :id_from_form

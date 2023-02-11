------------------------------------------------------------------------------
-- Members queries --
------------------------------------------------------------------------------
-- select all Members --
SELECT Members.member_id, Members.f_name, Members.l_name, Members.address,
    Members.birthday, Members.membership_plan_id, Members.gym_id
FROM Members 
INNER JOIN Membership_plans ON Members.membership_plan_id = Membership_plans.membership_plan_id
LEFT JOIN Gyms ON Members.gym_id = Gyms.gym_id

-- add new Member --
INSERT INTO Members(f_name, l_name, address, birthday, membership_plan_id, gym_id)
VALUES (:f_nameInput,
        :l_nameInput,
        :addressInput,
        :birthdayInput,
        :membership_plan_idInput,
        :gym_idInput)

-- update member data --
SELECT  Members.member_id,
        Members.f_name,
        Members.l_name,
        Members.address,
        Members.birthday,
        Members.membership_plan_id,
        Members.gym_id
FROM Members WHERE member_id = :member_id_selected_from_browse_member_page
UPDATE Members
SET f_name = :new_first_name,
    l_name = :new_last_name,
    address = :new_address,
    birthday = :new_birthday,
    membership_plan_id = :new_membership_plan_id,
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

-- update gym --
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
SELECT * from Membership_plans


-- add new membership plan --
INSERT INTO Membership_plans(monthly_fee, weight_cardio, spa_room, lap_pool, ballcourt)
VALUES (:monthly_feeInput,
        :weight_cardioInput,
        :spa_roomInput,
        :lap_poolInput,
        :ballcourtInput)

-- update membership plan --
UPDATE Membership_plans
SET monthly_fee = :new_monthly_fee
    weight_cardio = :new_weight_cardio
    spa_room = :new_spa_room
    lap_pool = :new_lap_pool
    ballcourt = :new_ballcourt
WHERE membership_plan_id = :id_from_form

-- delete membership plan --
DELETE FROM Membership_plans
WHERE membership_plan_id = :id_from_form



------------------------------------------------------------------------------
-- Workout classes queries --
------------------------------------------------------------------------------
-- select all workout classes --
SELECT  Workout_classes.workout_class_id, 
        Workout_classes.class_type, 
        Workout_classes.schedule,
        Workout_classes.duration,
        Instructors.instructor_id,
        Instructors.f_name
FROM Workout_classes
    INNER JOIN Instructors ON Workout_classes.instructor_id = Instructors.instructor_id

-- add new workout class --
INSERT INTO Workout_classes(class_type, duration, instructor_id, schedule)
VALUES (:class_typeInput, :durationInput, :instructor_idInput, :scheduleInput)

-- update workout class --
UPDATE Workout_classes
SET class_type = :new_class_type
    schedule = :new_schedule
    duration = :new_duration
    instructor_id = :new_instructor_id
WHERE workout_class_id = :id_from_form

-- delete workout class --
DELETE FROM Workout_classes
WHERE workout_class_id = :id_from_form



------------------------------------------------------------------------------
-- Class Participants queries --
------------------------------------------------------------------------------
-- select all Class Participants --
------------------------------------------------------------------------------
SELECT Members_workouts.member_workout_id, Members_workouts.workout_class_id, Workout_classes.class_type, Workout_classes.schedule, Members.member_id, Members.f_name, Members.l_name
FROM Members 
	JOIN Members_workouts ON Members.member_id = Members_workouts.member_id
	JOIN Workout_classes ON Members_workouts.workout_class_id = Workout_classes.workout_class_id

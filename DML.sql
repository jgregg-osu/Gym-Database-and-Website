------------------------------------------------------------------------------
-- Members queries --
------------------------------------------------------------------------------
SELECT Members.member_id, Members.f_name, Members.l_name, Members.address,
    Members.birthday, Members.membership_plan_id, Members.gym_id
FROM Members 
INNER JOIN Membership_plans ON Members.membership_plan_id = Membership_plans.membership_plan_id 

-- add a new Member --
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
-- Workout class queries --
------------------------------------------------------------------------------
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
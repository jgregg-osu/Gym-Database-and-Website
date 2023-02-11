-- get all members and their information for the browse Member page --
SELECT Members.member_id, Members.f_name, Members.l_name, Members.address,
    Members.birthday, Members.membership_plan_id, Members.gym_id
FROM Members 
INNER JOIN Membership_plans ON Members.membership_plan_id = Membership_plans.membership_plan_id 

-- add a new Member --
INSERT INTO Members(f_name, l_name, address, birthday, membership_plan_id, gym_id)
VALUES (:f_nameInput, :l_nameInput, :addressInput, :birthdayInput, :membership_plan_idInput, :gym_idInput)

-- update member data --
SELECT Members.member_id, Members.f_name, Members.l_name, Members.address, Members.birthday, Members.membership_plan_id, Members.gym_id
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


-- Return all instructor information --

-- add new Instructor --
INSERT INTO Instructors(f_name, l_name, address, birthday, email, phone_number, gym_id)
VALUES (:f_nameInput,:l_nameInput, :addressInput, :birthdayInput, :emailInput, :phoneInput, :gym_idInput)

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



-- Return all gym information --

-- add new gym --
INSERT INTO Gyms()
VALUES ()

-- update gym --
UPDATE Gyms
SET gym_address = :new_gym_address
    opening_time = :new_opening_time
    closing_time = :new_closing_time
WHERE gym_id = :id_from_form

-- delete gym --


-- Return all membership plan information --

-- add new membership plan --
INSERT INTO Membership_plans()
VALUES ()

-- update membership plan --
UPDATE Membership_plans
SET monthly_fee = :new_monthly_fee
    weight_cardio = :new_weight_cardio
    spa_room = :new_spa_room
    lap_pool = :new_lap_pool
    ballcourt = :new_ballcourt
WHERE membership_plan_id = :id_from_form

-- delete membership plan --


-- Return all workout class information --

-- add new workout class --
INSERT INTO ()
VALUES ()

-- update workout class --
UPDATE Workout_classes
SET class_type = :new_class_type
    schedule = :new_schedule
    duration = :new_duration
    instructor_id = :new_instructor_id
WHERE workout_class_id = :id_from_form

-- delete workout class --
-- get all members and their information for the browse Member page --
SELECT Members.member_id, Members.f_name, Members.l_name, Members.address, Members.birthday, Members.membership_plan_id, Members.gym_id
FROM Members 
INNER JOIN Membership_plans ON Members.membership_plan_id = Membership_plans.membership_plan_id 

-- add a new Member --
INSERT INTO Members(f_name, l_name, address, birthday, membership_plan_id, gym_id)
VALUES (:f_nameInput, :l_nameInput, :addressInput, :birthdayInput, :membership_plan_idInput, :gym_idInput)

-- update member data --
SELECT Members.member_id, Members.f_name, Members.l_name, Members.address, Members.birthday, Members.membership_plan_id, Members.gym_id
FROM Members WHERE member_id = :member_id_selected_from_browse_member_page

-- Delete member


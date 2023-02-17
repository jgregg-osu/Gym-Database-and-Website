-- -----------------------------------------------------
-- Project Group 36
-- Edward Mai
-- Jonathan Gregg
-- -----------------------------------------------------

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- -----------------------------------------------------
-- `Gyms` Table
-- -----------------------------------------------------
CREATE OR REPLACE TABLE Gyms (
    gym_id INT(3) NOT NULL AUTO_INCREMENT,
    gym_address varchar(200) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL,
    PRIMARY KEY(gym_id)
);

-- -----------------------------------------------------
-- `Gyms` Data
-- -----------------------------------------------------
INSERT INTO Gyms (gym_address, opening_time, closing_time)
VALUES ('100 E Jacked St. Swoleville City, CA 91990', '05:00:00', '22:00:00'),
    ('59 E Yoked Ave. Massive City, CA 92009', '05:00:00', '21:00:00'),
    ('123 Fake St. Irvine, CA 92602', '05:00:00', '23:00:00'),
    ('83 Edison Blvd. Pasadena, CA 91001', '05:00:00', '22:00:00'),
    ('53135 Birch Way. Rancho Cucamonga, CA 91701', '05:00:00', '21:00:00');

-- -----------------------------------------------------
-- `Plans` Table
-- -----------------------------------------------------
CREATE OR REPLACE TABLE Plans (
    plan_id TINYINT(2) NOT NULL AUTO_INCREMENT,
    monthly_fee DECIMAL(10,2) NOT NULL,
    weight_cardio BOOLEAN NOT NULL,
    spa_room BOOLEAN NOT NULL,
    lap_pool BOOLEAN NOT NULL,
    ballcourt BOOLEAN NOT NULL,
    PRIMARY KEY(plan_id)
);

-- -----------------------------------------------------
-- `Plans` Data
-- -----------------------------------------------------
INSERT INTO Plans (monthly_fee, weight_cardio, spa_room, lap_pool, ballcourt)
VALUES (20.00, 1, 0, 0, 0),
    (30.00, 1, 1, 0, 0 ),
    (40.00, 1, 1, 1, 0 ),
    (50.00, 1, 1, 1, 1 );

-- -----------------------------------------------------
-- `Members` Table
-- -----------------------------------------------------
CREATE OR REPLACE TABLE Members (
    member_id INT(5) NOT NULL AUTO_INCREMENT,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    address VARCHAR(200) NOT NULL,
    birthday DATE NOT NULL,
    plan_id TINYINT(2) NOT NULL DEFAULT 1,
    gym_id INT(3),
    PRIMARY KEY(member_id),
    FOREIGN KEY(plan_id) REFERENCES Plans(plan_id) ON DELETE RESTRICT,
    FOREIGN KEY(gym_id) REFERENCES Gyms(gym_id) ON DELETE SET NULL
);

-- -----------------------------------------------------
-- `Members` Data
-- -----------------------------------------------------
INSERT INTO Members (f_name, l_name, address, birthday, plan_id, gym_id)
VALUE ('Andrea', 'Lopez', '7104 S Miller Dr., San Pablo, CA 94806', '1986-04-20', 2, NULL), -- member left or gym is gone due to NULL
    ('Kevin', 'Nguyen', '7785 Ridgewood Court, Front Royal, CA 92630', '1991-10-20', 3, 2),
    ('Jimothy', 'Bernoulli', '3345 Friesian Walk, Santa Ana, CA 92701', '1967-11-07', 4, 5),
    ('Donathan', 'Oyamada', '638 On-Belay Rd., Pomona, CA 91750', '2005-01-01', 4, 4),
    ('Kenjamin', 'Dyson', '1153 Northumberland Dr., Bonting, CA 98765', '1999-03-20', 2, 4);

-- -----------------------------------------------------
-- `Instructors` Table
-- -----------------------------------------------------
CREATE OR REPLACE TABLE Instructors(
    instructor_id INT(3) NOT NULL AUTO_INCREMENT,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    address VARCHAR(200) NOT NULL,
    birthday DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    gym_id INT(3),
    PRIMARY Key(instructor_id),
    FOREIGN KEY(gym_id) REFERENCES Gyms(gym_id) ON DELETE SET NULL
);

-- -----------------------------------------------------
-- `Instructors` Data
-- -----------------------------------------------------
INSERT INTO Instructors (f_name, l_name, address, birthday, email, phone_number, gym_id)
VALUES ('Pedro', 'Pascal', '49 Ann St. Alabaster, CA 95007', '1975-04-02', 'PascalPedro@hollywood.com', '213-795-4636', 2),
    ('Miley', 'Kunis', '640 W. Studebaker St., Southfield, CA 98076', '1983-08-14', 'KunisMiley@gmail.com', '714-990-6531', 1),
    ('Lee', 'Mack', '2213 McKillop Ln., Irvine, CA 92602', '1968-08-04', 'LMack@gmail.com', '213-664-4309', 3),
    ('David', 'Mitchell', '748 Stuart Ave., Claremont, CA 91711', '1974-07-14', 'DMitchell@gmail.com', '616-495-3398', 3),
    ('Rob', 'Brydon', '8678 Baglan Way, Front Royal, CA 92630', '1965-05-03', 'BrybryBAFTA@gmail.com', '909-860-2769', NULL);

-- -----------------------------------------------------
-- `Classes` Table
-- -----------------------------------------------------
CREATE OR REPLACE TABLE Classes(
    class_id INT(3) NOT NULL AUTO_INCREMENT,
    class_type VARCHAR(50) NOT NULL,
    duration INT(3) NOT NULL,
    instructor_id INT(3) NOT NULL,
    schedule DATETIME NOT NULL,
    PRIMARY KEY(class_id),
    FOREIGN KEY(instructor_id) REFERENCES Instructors(instructor_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- `Classes` Data
-- -----------------------------------------------------
INSERT INTO Classes (class_type, duration, instructor_id, schedule)
VALUES ('HIIT', 60, 1, '2023-03-14 09:00:00'),
    ('Yoga', 45, 2, '2023-03-27 07:00:00'),
    ('Spin', 60, 4, '2023-03-14 09:00:00'),
    ('Crossfit', 90, 3, '2023-03-15 07:00:00'),
    ('Pilates', 90, 5, '2023-03-18 09:00:00');

-- -----------------------------------------------------
-- `Members_classes` Table
-- -----------------------------------------------------
CREATE OR REPLACE TABLE Class_participants (
    member_class_id INT(7) NOT NULL AUTO_INCREMENT,
    member_id INT(5) NOT NULL,
    class_id INT(3) NOT NULL,
    PRIMARY KEY(member_class_id),
    FOREIGN KEY(member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY(class_id) REFERENCES Classes(class_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- `Members_classes` Data
-- -----------------------------------------------------
INSERT INTO Class_participants ( member_id, class_id)
VALUES (1, 2),
    (2,1),
    (2,2),
    (4,2),
    (5,2);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

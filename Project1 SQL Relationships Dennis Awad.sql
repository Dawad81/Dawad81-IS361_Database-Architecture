/* This database registers students in the Information System  Major in to IS classes. 
It can be used to come up with class rosters and additionaly, be used to create email list per class 
so a teacher can retrieve the emails for the students registered for their class.
It can also retrieve how many credits total each student is taken per semester.*/

DROP TABLE IF EXISTS student_table;

-- This creates the list of students
CREATE TABLE student_table (
					student_id int PRIMARY KEY,
					first_name VARCHAR(20) NOT NULL ,
                    last_name VARCHAR(20) NOT NULL,
                    email VARCHAR(100)NOT NULL);
                    
INSERT INTO student_table (student_id, first_name, last_name, email) VALUES (01, 'Dennis', 'Awad', 'DennisA32@gmail.com');
INSERT INTO student_table (student_id, first_name, last_name, email) VALUES (02, 'Nicole', 'Almas', 'NicoleA@gmail.com');
INSERT INTO student_table (student_id, first_name, last_name, email) VALUES (03, 'Paul', 'Bonfilio', 'P_bonfilio@Aol.com');
INSERT INTO student_table (student_id, first_name, last_name, email) VALUES (04, 'Alexis', 'Ferusio', 'AlexisF@spsmail.cuny.edu');
INSERT INTO student_table (student_id, first_name, last_name, email) VALUES (05, 'Lyle', 'Johnson', 'Kamilion@gmail.com');


SELECT * FROM student_table;-- This displays the student_table.



DROP TABLE IF EXISTS course_table;

-- this creates the course_table
CREATE TABLE course_table (
					course_id int PRIMARY KEY,
                    course_number VARCHAR(20) NOT NULL,
					course_name VARCHAR(100) NOT NULL ,
                    credits INT,
                    semester VARCHAR(50));
                    
INSERT INTO course_table (course_id, course_number, course_name, credits, semester) VALUES (01, 'IS 361', 'Database Architecture and Programming', 3, 'Fall 2019');
INSERT INTO course_table (course_id, course_number, course_name, credits, semester) VALUES (02, 'IS 210', 'Application Programming 1', 3, 'Fall 2019');
INSERT INTO course_table (course_id, course_number, course_name, credits, semester) VALUES (03, 'IS 211', 'Application Programming 2', 3, 'Fall 2019');
INSERT INTO course_table (course_id, course_number, course_name, credits, semester) VALUES (04, 'IS 326', 'E-Commerce', 3, 'Fall 2019');
INSERT INTO course_table (course_id, course_number, course_name, credits, semester) VALUES (05, 'IS 250', 'Computer and Network Security', 3, 'Fall 2019');


SELECT * FROM course_table;-- this displays the course_table.

DROP TABLE IF EXISTS registration_table;

-- this creates the registration_table
CREATE TABLE registration_table (
					registration_id int PRIMARY KEY,
					course_id int REFERENCES course_table,
                    student_id int REFERENCES student_table);

INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (01, 01, 01);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (02, 01, 02);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (03, 01, 03);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (04, 01, 04);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (05, 01, 05);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (06, 02, 01);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (07, 02, 02);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (08, 03, 03);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (09, 03, 04);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (10, 04, 05);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (11, 04, 04);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (12, 05, 03);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (13, 05, 02);
INSERT INTO registration_table (registration_id, course_id, student_id) VALUES (14, 05, 05);


-- this displays the registration_table.
SELECT * FROM registration_table;


-- This displays who is registered for which classes listing all the classes.
SELECT
ct.course_number, ct.course_name, ct.semester,
st.last_name, st.first_name, st.email
FROM registration_table rt
LEFT JOIN student_table st
ON st.student_id = rt.student_id
LEFT JOIN course_table ct
ON rt.course_id = ct.course_id
-- WHERE ct.course_number = 'IS 361'
ORDER BY ct.course_name, ct.course_number, ct.semester, st.last_name, st.first_name;



/* Below the folowing 5 select statments display students regestered for each class, along with their emails.*/


-- This statment shows who is registerd for IS 361 and their email address
SELECT
CONCAT(st.last_name,', ', st.first_name) AS 'Students Registered for IS 361 - Database Architecture and Programming',
st.email
FROM registration_table rt
LEFT JOIN student_table st
ON st.student_id = rt.student_id
LEFT JOIN course_table ct
ON rt.course_id = ct.course_id
WHERE ct.course_number = 'IS 361'
ORDER BY ct.course_name, ct.course_number, ct.semester, st.last_name, st.first_name;


-- This statment shows who is registerd for IS 210 and their email address
SELECT
CONCAT(st.last_name,', ', st.first_name) AS 'Students Registered for IS 210 - Application Programming 1',
st.email
FROM registration_table rt
LEFT JOIN student_table st
ON st.student_id = rt.student_id
LEFT JOIN course_table ct
ON rt.course_id = ct.course_id
WHERE ct.course_number = 'IS 210'
ORDER BY ct.course_name, ct.course_number, ct.semester, st.last_name, st.first_name;


-- This statment shows who is registerd for IS 211 and their email address
SELECT
CONCAT(st.last_name,', ', st.first_name) AS 'Students Registered for IS 211 - Application Programming 2',
st.email
FROM registration_table rt
LEFT JOIN student_table st
ON st.student_id = rt.student_id
LEFT JOIN course_table ct
ON rt.course_id = ct.course_id
WHERE ct.course_number = 'IS 211'
ORDER BY ct.course_name, ct.course_number, ct.semester, st.last_name, st.first_name;


-- This statment shows who is registerd for IS 326 and their email address
SELECT
CONCAT(st.last_name,', ', st.first_name) AS 'Students Registered for IS 326 - E-Commerce',
st.email
FROM registration_table rt
LEFT JOIN student_table st
ON st.student_id = rt.student_id
LEFT JOIN course_table ct
ON rt.course_id = ct.course_id
WHERE ct.course_number = 'IS 326'
ORDER BY ct.course_name, ct.course_number, ct.semester, st.last_name, st.first_name;


-- This statment shows who is registerd for IS 250 and their email address
SELECT
CONCAT(st.last_name,', ', st.first_name) AS 'Students Registered for IS 250 - Computer and Network Security',
st.email
FROM registration_table rt
LEFT JOIN student_table st
ON st.student_id = rt.student_id
LEFT JOIN course_table ct
ON rt.course_id = ct.course_id
WHERE ct.course_number = 'IS 250'
ORDER BY ct.course_name, ct.course_number, ct.semester, st.last_name, st.first_name;






/* The following Selesct statments show what clases a student is registered for.*/


-- The following Select statment shows alll the classes Lyle Johnson student with  ID #: 5, is registered for.
SELECT
CONCAT(ct.course_number, ' - ', ct.course_name) as 'CLasses  Lyle Johnson is registered for'
FROM registration_table rt
LEFT JOIN student_table st
ON st.student_id = rt.student_id
LEFT JOIN course_table ct
ON rt.course_id = ct.course_id
WHERE rt.student_id = 5;


-- The following Select statment shows all the classes Dennis Awad student with  ID #: 1, is registered for.
SELECT
CONCAT(ct.course_number, ' - ', ct.course_name) as 'CLasses Dennis Awad is registered for'
FROM registration_table rt
LEFT JOIN student_table st
ON st.student_id = rt.student_id
LEFT JOIN course_table ct
ON rt.course_id = ct.course_id
WHERE rt.student_id = 1;

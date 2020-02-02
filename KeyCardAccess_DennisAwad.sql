/*KeyCardAccess_DennisAwad.sql*/


DROP TABLE IF EXISTS users_table;

-- This creates the list of Users with their group number, forming the users_table.
CREATE TABLE users_table ( 
						user_id int PRIMARY KEY,
						user_name VARCHAR(30) NOT NULL,
						group_number INT);
                    
INSERT INTO users_table (user_id, user_name, group_number) VALUES (01, 'Modesto',1);
INSERT INTO users_table (user_id, user_name, group_number) VALUES (02, 'Ayine',1);
INSERT INTO users_table (user_id, user_name, group_number) VALUES (03, 'Christopher',2);
INSERT INTO users_table (user_id, user_name, group_number) VALUES (04, 'Cheong woo',2);
INSERT INTO users_table (user_id, user_name, group_number) VALUES (05, 'Saulat',3);
INSERT INTO users_table (user_id, user_name, group_number) VALUES (06, 'Heidy',NULL);

SELECT * FROM users_table;-- This displays the users_table.



DROP TABLE IF EXISTS group_table;

-- this creates the group_table (list of groups who need access)
CREATE TABLE group_table (
					group_id int PRIMARY KEY,
					group_name VARCHAR(100));
                    
INSERT INTO group_table (group_id, group_name) VALUES (01, 'I.T.');
INSERT INTO group_table (group_id, group_name) VALUES (02, 'Sales');
INSERT INTO group_table (group_id, group_name) VALUES (03, 'Administration');
INSERT INTO group_table (group_id, group_name) VALUES (04, 'Operations');

SELECT * FROM group_table;-- this displays the group_table.


DROP TABLE IF EXISTS room_table;

-- this creates the rooms available that need to be assigned to groups that form the room_table.
CREATE TABLE room_table (
					room_id int PRIMARY KEY,
					room_name VARCHAR(30));
                    
INSERT INTO room_table (room_id, room_name) VALUES (01, '101');
INSERT INTO room_table (room_id, room_name) VALUES (02, '102');
INSERT INTO room_table (room_id, room_name) VALUES (03, 'Auditorium A');
INSERT INTO room_table (room_id, room_name) VALUES (04, 'Auditorium B');


SELECT * FROM room_table;-- this displays the room_table.



DROP TABLE IF EXISTS group_rooms;

-- this creates the association of thr grrops and what rooms they have access to called group_rooms.
CREATE TABLE group_rooms (
					group_rooms_id int PRIMARY KEY,
					group_id int REFERENCES group_table,
                    room_id int REFERENCES room_table);

INSERT INTO group_rooms (group_rooms_id, group_id, room_id) VALUES (01, 01, 01);
INSERT INTO group_rooms (group_rooms_id, group_id, room_id) VALUES (02, 01, 02);
INSERT INTO group_rooms (group_rooms_id, group_id, room_id) VALUES (03, 02, 02);
INSERT INTO group_rooms (group_rooms_id, group_id, room_id) VALUES (04, 02, 03);
INSERT INTO group_rooms (group_rooms_id, group_id, room_id) VALUES (05, 03, NULL);
INSERT INTO group_rooms (group_rooms_id, group_id, room_id) VALUES (06, 04, NULL);

-- this displays the group_rooms.
SELECT * FROM group_rooms;



/*This select statement list all groups, and the users in each group. 
A group will appear even if there are no users assigned to the group.*/
SELECT gt.group_name, ut.user_name 
FROM group_table gt-- users_table ut
LEFT JOIN users_table ut -- group_table gt
ON gt.group_id = ut.group_number
-- WHERE ut.group_number = gt.group_id 
ORDER BY gt.group_name, ut.user_name;


/* This select statment list all rooms, and the groups assigned to each room. 
The rooms will appear even if no groups have been assigned to them.*/
SELECT rt.room_name, gt.group_name
FROM room_table rt
LEFT JOIN group_rooms gr
ON gr.room_id = rt.room_id
LEFT JOIN group_table gt
ON gr.group_id = gt.group_id
ORDER BY rt.room_name;


/* This select statment displays a list of users, the groups that they belong to,
and the rooms to which they are assigned. This should is sorted alphabetically 
by user, then by group, then by room.*/
SELECT ut.user_name, gt.group_name, rt.room_name
FROM users_table ut
LEFT JOIN group_table gt
ON ut.group_number = gt.group_id
LEFT JOIN group_rooms gr
ON gr.group_id = gt.group_id
LEFT JOIN room_table rt
ON rt.room_id = gr.room_id
ORDER BY ut.user_name, gt.group_name, rt.room_name;

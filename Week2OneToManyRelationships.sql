DROP TABLE IF EXISTS videos_table;


CREATE TABLE videos_table (
					vid_id int PRIMARY KEY,
					title VARCHAR(100) NOT NULL ,
                    length VARCHAR(10),
                    url VARCHAR(100)NOT NULL);
                    
INSERT INTO videos_table (vid_id, title, length, url) VALUES (1, 'Studio Tour', '6:57', 'https://youtu.be/NqBrrLohHmE');
INSERT INTO videos_table (vid_id, title, length, url) VALUES (2, 'Cinema Lens on a $600 Mirrorless Camera = EPIC Cinematic Canon M50 ??', '12:13', 'https://youtu.be/fdrn1FjkLf8');
INSERT INTO videos_table (vid_id, title, length, url) VALUES (3, 'EDITING COMMAND STATION! Our Office Makeover Tour!', '13:27', 'https://youtu.be/KwTYeOz7kYc');

SELECT * FROM videos_table;



DROP TABLE IF EXISTS reviewers_table;

CREATE TABLE reviewers_table (
					review_id int PRIMARY KEY,
                    vid_id INT NOT NULL REFERENCES videos_table,
					user VARCHAR(20) NOT NULL ,
                    rating INT,
                    reviews VARCHAR(100)NOT NULL);
                    
INSERT INTO reviewers_table (review_id, vid_id, user, rating, reviews) VALUES (1, 1, 'SassMasterD', 5, 'Great studio!');
INSERT INTO reviewers_table (review_id, vid_id, user, rating, reviews) VALUES (2, 1, 'AlexD', 4, 'Cool Vid, more please.');
INSERT INTO reviewers_table (review_id, vid_id, user, rating, reviews) VALUES (3, 2, 'LilSandz', 3, 'Great editing, but super long vid.');
INSERT INTO reviewers_table (review_id, vid_id, user, rating, reviews) VALUES (4, 2, 'Nalmas', 2, 'too long');
INSERT INTO reviewers_table (review_id, vid_id, user, rating, reviews) VALUES (5, 3, 'LilJ', 1, 'borning video on good topic');
INSERT INTO reviewers_table (review_id, vid_id, user, rating, reviews) VALUES (6, 3, 'Mawad', 0, 'I want my click back');

SELECT * FROM reviewers_table;


SELECT
vid.vid_id AS 'Video ID',
vid.title AS 'Title',
vid.length AS 'Length',
vid.url AS 'URL',
rev.user AS 'User',
rev.rating AS 'Rating',
rev.reviews AS 'Review'
FROM videos_table AS vid
JOIN reviewers_table AS rev
ON vid.vid_id = rev.vid_id;




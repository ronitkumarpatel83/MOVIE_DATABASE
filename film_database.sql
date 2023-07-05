CREATE DATABASE FILM_DATABASE;
USE FILM_DATABASE;

-- ---------- CREATING TABLES -----------------------

CREATE TABLE ARTIST(Art_id INT PRIMARY KEY, Art_Name VARCHAR(50), Art_Gender VARCHAR(20));
CREATE TABLE PRODUCER(Prod_id INT PRIMARY KEY, Prod_Name VARCHAR(50), Prod_Phone VARCHAR(50));
CREATE TABLE FILMS(Film_id INT PRIMARY KEY, Film_Title VARCHAR(150), Film_Year INT, Film_Lang VARCHAR(50), Prod_id INT);
CREATE TABLE CASTING(Art_id INT PRIMARY KEY, Film_id INT, Part VARCHAR(20)); 
CREATE TABLE REVIEW(Film_id INT PRIMARY KEY, Stars INT); 

-- ----------- VIEW TABLE DETAILS --------------------

SELECT * FROM ARTIST;
SELECT * FROM PRODUCER;
SELECT * FROM FILMS;
SELECT * FROM CASTING;
SELECT * FROM REVIEW;

-- ----------- INSERTING DATA INTO TABLES -------------------
-- ----------- ARTIST TABLES --------------------------------

INSERT INTO ARTIST VALUES(1, "VEER", "MALE");
INSERT INTO ARTIST VALUES(2, "RUHI", "MALE");
INSERT INTO ARTIST VALUES(3, "RONIT", "MALE");
INSERT INTO ARTIST VALUES(4, "MAHI", "MALE");
INSERT INTO ARTIST VALUES(5, "AVNI", "MALE");

-- ----------- PRODUCER TABLES -------------------------------------

INSERT INTO PRODUCER VALUES(101, "RAHEJA", "9876543210");
INSERT INTO PRODUCER VALUES(102, "CHAUHAN", "8745625841");
INSERT INTO PRODUCER VALUES(103, "PATEL", "7896541230");
INSERT INTO PRODUCER VALUES(104, "SAHU", "6547893217");
INSERT INTO PRODUCER VALUES(105, "JENA", "7893214565");

-- ------------ FILMS TABLES ----------------------------------------

INSERT INTO FILMS VALUES(1001, "SUPER GENE", 2016, "CHINESE", 101);
INSERT INTO FILMS VALUES(1002, "DRAGON BALLS", 2017, "HINDI", 102);
INSERT INTO FILMS VALUES(1003, "NARUTO", 2015, "CHINESE", 103);
INSERT INTO FILMS VALUES(1004, "JUJUTSU KAISEN", 2018, "CHINESE", 104);
INSERT INTO FILMS VALUES(1005, "HARRY POTTER", 2001, "CHINESE", 105);

-- ------------- CASTING TABLES ---------------------------------------

INSERT INTO CASTING VALUES(1, 1001, "11");
INSERT INTO CASTING VALUES(2, 1002, "3");
INSERT INTO CASTING VALUES(3, 1003, "5");
INSERT INTO CASTING VALUES(4, 1004, "4");
INSERT INTO CASTING VALUES(5, 1005, "8");

-- ------------- REVIEW TABLES -----------------------------------------

INSERT INTO REVIEW VALUES(1001, 8);
INSERT INTO REVIEW VALUES(1002, 4);
INSERT INTO REVIEW VALUES(1003, 5);
INSERT INTO REVIEW VALUES(1004, 6);
INSERT INTO REVIEW VALUES(1005, 7);

-- -------------- QUERIES -----------------------------------------------
-- 1.Find the name of all the Films whose producer is “NIRAJ”. First we will find the Producer ID for the Producer Named “NIRAJ” and for this we use the PRODUCER table.

SELECT Film_Title FROM FILMS WHERE Prod_id IN (SELECT Prod_id FROM PRODUCER WHERE Prod_Name = "PATEL");

-- 2. Which movie is releasing on particular releasing date 

SELECT Film_Title FROM FILMS WHERE Film_Year = 2001;

-- 3 .Display all artists who acted in a film between 2016 and 2018.
SELECT Art_Name FROM ARTIST 
WHERE Art_id 
IN (SELECT Art_id FROM CASTING 
WHERE Film_id 
IN (SELECT Film_id FROM FILMS 
WHERE Film_Year BETWEEN 2016 AND 2018));

-- 4. Display the names of films with the stars received and sort the result on the basis of stars.

SELECT F.Film_title, R.Stars 
FROM FILMS F, REVIEW R 
WHERE F.Film_id = R.Film_id
ORDER BY R.Stars DESC;

-- 5. Update the stars of all films whose producer is ‘NIRAJ’ to 5
UPDATE REVIEW SET Stars = 5 WHERE Film_id IN 
(SELECT Film_id FROM FILMS WHERE Prod_id IN 
(SELECT Prod_id FROM PRODUCER WHERE Prod_Name = "JENA"));

-- 6. FILMS AND CASTING FULL OUTER JOINS.
SELECT * FROM FILMS LEFT JOIN CASTING 
ON FILMS.Film_id = CASTING.Film_id
UNION ALL
SELECT * FROM FILMS RIGHT JOIN CASTING
ON FILMS.Film_id = CASTING.Film_id;


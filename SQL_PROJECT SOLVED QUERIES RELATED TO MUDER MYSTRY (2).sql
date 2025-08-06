use sql_project;

-- 1.Find the exact details of crime_scene where type is murder
select *
from crime_scene
where Type = 'murder';

-- 2. CTE to get all people who checked in gym on crime day
with suspects AS(
	select c.Membership_Id,m.name,c.check_in_date
	From getfitnow_check_in c
    join getfitnow_members m on c.membership_id = m.id
    where date(c.check_in_date) = "2017-01-11"
)
select *
from suspects;


-- 3. Find who left gym immediately after check-in (possible escape)
WITH check_times AS (
  SELECT m.name, c.check_in_date
  FROM getfitnow_check_in c
  JOIN getfitnow_members m ON c.membership_id = m.id
  WHERE DATE(c.check_in_date) = '2017-01-15'
)
SELECT * FROM check_times
ORDER BY check_in_date;

-- 4.used order by 
select *
from Person
where Address_Street_Name = 'Northwestern Dr'
order by Address_Number desc;

-- 5. where clause to show date "yyyy-mm-dd"
 select *
from GetFitNow_check_in
where Check_In_Date ='2018-01-09';

-- 6.find the total number of check ins for each member,showing their name and the total count 
SELECT 
	m.name,
    count(c.membership_id) AS total_check_ins
FROM getfitnow_members AS m
JOIN getfitnow_check_in AS c 
ON m.id = c.membership_id
GROUP BY m.name
ORDER BY total_check_ins DESC;

-- 7.Find the names of people who have interview related to crime scene in "Springfield"
with SpringfieldCrimes AS (
	SELECT city
    FROM crime_scene
    WHERE city = "Springfield"
)
SELECT 
	p.name,
    i.Transcript
FROM person AS p
join interviews as i
on p.id = i.person_id;

--  8.Create the view to easily acccess person name , address, and make of their car where car model is "ford"
CREATE VIEW VW_PersonCarInfo AS
SELECT
    p.name,
    p.address_street_name,
    d.car_make,
    d.car_model
FROM
    Person AS p
JOIN
    Drivers_license AS d ON p.license_id = d.id;

-- Step 2: Query the view
SELECT
    name,
    address_street_name,
    car_model,
    car_make
FROM
    VW_PersonCarInfo
WHERE
    car_make = 'Ford';
    
    
-- 9.Find the names of members who joined in the year 2018. 
-- This shows how to use a date-related function within a WHERE clause.
SELECT
    name,
    Membership_Start_Date
FROM
    GetFitNow_members
WHERE name like '%Y' and Membership_Start_Date = "2018";

-- 10. Find the person_id, name, and car details of a person who is a suspect based on a vague description from an interview.
-- The interview text says the suspect is a female with red hair.
SELECT
    p.id,
    p.name,
    d.car_make,
    d.car_model,
	d.gender,
    d.hair_color
    
FROM
    Person AS p
JOIN
    Drivers_license AS d ON p.license_id = d.id
JOIN
    Interviews AS i ON p.id = i.person_id
WHERE
    d.gender = 'Female' AND d.hair_color = 'Red';




-- MOVIELENS
 --  1 List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
 SELECT * FROM movies WHERE release_date between "1983-01-01" AND "1993-12-31" ORDER BY RELEASE_DATE DESC;
 
 --  2Without using LIMIT, list the titles of the movies with the lowest average rating.
  SELECT m.title, AVG(r.rating)
FROM movies m
JOIN ratings r on m.id=r.movie_id
group by (m.title) order by (r.rating);
 
  -- 3 List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
  CREATE VIEW ratinguser
AS
select gender,age, ID
FROM users
where age = "24" and gender = "m" ORDER BY ID;

create view 24mst as
select u.id, u.gender, u.age, o.name from users as u
join occupations as o on u.occupation_id = o.id
where o.name = "student" and u.age = 24 and u.gender = "m";

create view rate as
select r.movie_id from ratings as r
join 24mst as m on r.user_id = m.id
where r.rating = 5;

create view scifi as
select m.id as pk_movie_id, m.title from movies as m
join genres_movies as gm on gm.movie_id = m.id
join genres as g on gm.genre_id = g.id
where g.name = "sci-fi";

select distinct(title) from scifi
join rate on scifi.pk_movie_id = rate.movie_id
order by title;


  
--   4 List the unique titles of each of the movies released on the most popular release day.

SELECT release_date, count(*) as maxcount
from movies
group by release_date;



select * 
from movies 
where release_date = "1995-01-01";


 --  5 Find the total number of movies in each genre; list the results in ascending numeric order.

SELECT genres.name, COUNT(gm.movie_id) AS counter FROM genres 
LEFT JOIN genres_movies AS gm ON gm.genre_id = genres.id
group by genres.id, genres.name
order by counter;

Fantasy	22
Film-Noir	24
Western	27
Animation	42
Documentary	50
Musical	56
Mystery	61
War	71
Horror	92
Sci-Fi	101
Crime	109
Children's	122
Adventure	135
Romance	247
Action	251
Thriller	251
Comedy	505
Drama	725







																				-- --------	---------------------------------------SAKILA------------------------------------------------------------------------------


  --   List all actors.
  SELECT * FROM actor;
  
--     Find the surname of the actor with the forename 'John'.
SELECT * FROM actor
where first_name = "john";

--     Find all actors with surname 'Neeson'.
SELECT * FROM actor
where last_name = "neeson";

--     Find all actors with ID numbers divisible by 10.
SELECT * FROM actor
where (actor_id%10) = 0;

--     What is the description of the movie with an ID of 100?
SELECT * FROM movielens.ratinguser;

A Beautiful Drama of a Dentist And a Composer who must Battle a Sumo Wrestler in The First Manned Space Station

--     Find every R-rated movie.
SELECT * FROM film
where rating = "r";

--     Find every non-R-rated movie.
SELECT * FROM film
where rating != "r";

--     Find the ten shortest movies.
SELECT * FROM film
order by length asc limit 10; 

--     Find the movies with the longest runtime, without using LIMIT.
SELECT * FROM film
order by length desc;

--     Find all movies that have deleted scenes.
SELECT * FROM film
where special_features LIKE "%deleted%";

--     Using HAVING, reverse-alphabetically list the last names that are not repeated.

SELECT min(last_name)
from actor
group by last_name;

--     Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name
FROM actor
group by last_name
HAVING COUNT(*) > 1;

--     Which actor has appeared in the most films?
SELECT actor_id, count(*) as maxcount
from film_actor
group by actor_id;

--     When is 'Academy Dinosaur' due?
select film_id from film where title = "academy dinosaur";
select inventory_id from inventory where film_id = "1";
select inventory_id, return_date from rental where inventory_id between 1 and 8;

--     What is the average runtime of all films?
select avg(length)
from film;
115.2720

--     List the average runtime for every film category.

select film.film_id,
	   film_category.category_id,
	   category.name,
       avg(film.length)
from film
	left outer join film_category
       on film.film_id = film_category.film_id
    left outer join category
       on film_category.category_id = category.category_id
group by category.name;
    
    

--     List all movies featuring a robot.

SELECT * FROM film
where description LIKE "%robot%";

--     How many movies were released in 2010?
SELECT * FROM film
where RELEASE_YEAR = "2010";

--     Find the titles of all the horror movies.

select * from movies as m
join genres_movies as gm on gm.movie_id = m.id
join genres as g on gm.genre_id = g.id
where name = "horror";

--     List the full name of the staff member with the ID of 2.
Jon Stephens 
select * from staff
where staff_id = "2";

--     List all the movies that Fred Costner has appeared in.
SELECT * FROM film_actor
where actor_id = "16";

--     How many distinct countries are there?
109 SELECT count(country) from country;

--     List the name of every language in reverse-alphabetical order.

SELECT * FROM language
ORDER BY name DESC;

--     List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.

select * from actor 
where last_name like "%son"
order by first_name;


--     Which category contains the most films? 

cat 15

select category_id, count(category_id)
from film_category
group by category_id;










-- 							-- 						-- ------------------------------------------------------------------------ WORLD -------------------------------------------------------------------------- 


 --    Using COUNT, get the number of cities in the USA.
 274
 select count(name)
from city
where countrycode = "usa";


--     Find out the population and life expectancy for people in Argentina.
'19996563'

select sum(population)
from city 
where countrycode = "arg";


75.10000

select avg(LifeExpectancy)
from country 
where code ="arg";



--     Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?

Andorra	83.5

select name, lifeexpectancy from country
where lifeexpectancy IS NOT NULL
order by lifeexpectancy desc
limit 1;


--     Using JOIN ... ON, find the capital city of Spain.

select *
from country c
join city y on c.capital = y.id
where id = "653";


--     Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.


--     Using a single query, list 25 cities around the world that start with the letter F.

select * from city
where name like "f%" limit 25;



--     Using COUNT and JOIN ... ON, get the number of cities in China.

select * 
from country c
join city y on c.code = y.countrycode
where code = "chn";


--     Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
Antarctica
SELECT * FROM country
where population IS NOT NULL
order by population asc limit 1;


--     Using aggregate functions, return the number of countries the database contains.
239
select count(name)
from country;

--     What are the top ten largest countries by area?
select * from country
order by surfacearea desc limit 10;


--     List the five largest cities by population in Japan.

select * from city
where countrycode = "jpn" LIMIT 5;



--     List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!

SELECT CODE, HEADOFSTATE
 FROM COUNTRY
WHERE HEADOFSTATE = "ELISABETH II";


--     List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.


--     List every unique world language.

SELECT min(LANGUAGE)
from COUNTRYLANGUAGE
group by LANGUAGE;


--     List the names and GNP of the world's top 10 richest countries.

SELECT * FROM COUNTRY
ORDER BY GNP DESC
LIMIT 10;

--     List the names of, and number of languages spoken by, the top ten most multilingual countries.

'English', '60'
'Spanish', '28'
'Uzbek', '6'
'Dutch', '5'
'Balochi', '4'
'Turkmenian', '3'
'Papiamento', '2'
'Pashto', '2'
'Dari', '1'
'Ambo', '1'


SELECT language, count(*) as maxcount
from countrylanguage
group by language limit 10;

--     List every country where over 50% of its population can speak German.
SELECT * FROM countrylanguage
where percentage > "50" and language = "german";


--     Which country has the worst life expectancy? Discard zero or null values.

SELECT * FROM country
where lifeexpectancy IS NOT NULL
order by LifeExpectancy asc;

--     List the top three most common government forms.

Nonmetropolitan Territory of The Netherlands	239
SELECT governmentform, count(*) as maxcount
from country;

--     How many countries have gained independence since records began?
192

SELECT count(indepyear)
from country
where indepyear IS NOT NULL;


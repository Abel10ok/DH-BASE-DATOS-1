-- MUESTRA_LAS_TABLAS_QUE_TENGO --
SHOW tables;

	-- SELECT --
SELECT * FROM movies;

SELECT first_name, last_name, rating 
FROM actors;

SELECT title
FROM series;

SELECT first_name, last_name, rating 
FROM actors 
WHERE rating > 7.5;

SELECT title, rating , awards 
FROM movies 
where rating > 7.5 AND awards > 2;

SELECT title, rating 
FROM MOVIES  
ORDER BY rating ASC ;

SELECT title, rating 
FROM movies 
where title LIKE "%TOY%";

SELECT * FROM actors 
WHERE first_name LIKE "Sam%";

SELECT title, release_date 
FROM movies 
WHERE release_date between "2004-01-01" AND "2008-12-31";

SELECT title AS titulo 
FROM series AS s;

SELECT title, rating , awards FROM movies 
WHERE rating > 3 AND awards > 1 AND release_date 
BETWEEN "1988-01-01" AND "2009-12-31"  
ORDER BY rating DESC;

SELECT title FROM movies 
WHERE rating > 3 AND AWARDS > 1 AND YEAR (release_date) 
BETWEEN "1988" AND "2009"  
ORDER BY rating DESC 
LIMIT 3 OFFSET 10;

SELECT title FROM movies 
WHERE rating > 3 AND AWARDS > 1 AND DAY (release_date) 
BETWEEN "1" AND "5"  
ORDER BY rating DESC 
LIMIT 3 OFFSET 10;

SELECT title FROM movies 
WHERE rating > 3 AND AWARDS > 1 AND MONTH (release_date) 
BETWEEN "1" AND "10"  
ORDER BY rating DESC 
LIMIT 3 OFFSET 10;

SELECT title, rating FROM episodes  
ORDER BY rating ASC 
LIMIT 3;

SELECT first_name AS "PRIMER NOMBRE", last_name AS "APELLIDO" , rating "REITING" FROM actors; 
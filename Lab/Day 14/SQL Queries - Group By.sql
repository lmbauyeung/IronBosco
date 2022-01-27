USE sakila;

-- 1. In the table actor, what last names are not repeated?
SELECT last_name, COUNT(last_name) as last_name_count FROM actor
GROUP BY 1
HAVING last_name_count <= 1;


-- 2. Which last names appear more than once? 
SELECT last_name, COUNT(last_name) as last_name_count FROM actor
GROUP BY 1
HAVING last_name_count > 1;


-- 3. Using the rental table, find out how many rentals were processed by each employee.
SELECT staff_id, COUNT(staff_id) as number_of_rentals
FROM rental
GROUP BY 1;


-- 4. Using the film table, find out how many films were released.
SELECT COUNT(release_year) as number_of_films_released
FROM film;


-- 5. Using the film table, find out how many films there are of each rating.
SELECT rating, COUNT(rating) AS count 
FROM film
GROUP BY 1;


-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT rating, ROUND(AVG(length),2) AS count 
FROM film
GROUP BY 1;


-- 7. Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, ROUND(AVG(length),2) AS count 
FROM film
GROUP BY 1
HAVING count > 120;
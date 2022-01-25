USE sakila;


-- 1. Which actor has appeared in the most films?
SELECT 
	a.actor_id, b.first_name, b.first_name, COUNT(*) as number_of_appearances
FROM 
	film_actor a
LEFT JOIN
	actor b ON a.actor_id = b.actor_id
GROUP BY 1
ORDER BY 4 DESC
LIMIT 1;


-- 2. Most active customer (the customer that has rented the most number of films)
SELECT
	a.customer_id, b.first_name, b.last_name, COUNT(*) AS number_of_rentals
FROM
	rental a
LEFT JOIN
	customer b ON a.customer_id = b.customer_id
GROUP BY 1
ORDER BY 4 DESC
LIMIT 1;


-- 3. List number of films per category.
SELECT
	a.category_id, b.name, COUNT(*) AS number_of_films
FROM
	film_category a
LEFT JOIN
	category b ON a.category_id = b.category_id
GROUP BY 1
ORDER BY 3 DESC;

-- 4. Display the first and last names, as well as the address, of each staff member.
SELECT
	a.first_name, a.last_name, b.address
FROM
	staff a
LEFT JOIN
	address b ON a.address_id = b.address_id;
    
    
-- 5. Display the total amount rung up by each staff member in August of 2005.
SELECT 
	a.staff_id, SUM(a.amount) AS total_amount, b.first_name, b.last_name
FROM
	payment a
LEFT JOIN
	staff b ON a.staff_id = b.staff_id
WHERE a.payment_date LIKE '2005-08%'
GROUP BY 1;


-- 6. List each film and the number of actors who are listed for that film.
SELECT
	a.film_id, COUNT(*) AS number_of_actors_listed
FROM
	film a
LEFT JOIN
	film_actor b ON a.film_id = b.film_id
GROUP BY 1;


-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name. Bonus: Which is the most rented film?
SELECT 
	a.customer_id, SUM(a.amount) AS total_amount, b.first_name, b.last_name
FROM
	payment a
LEFT JOIN
	customer b ON a.customer_id = b.customer_id
GROUP BY 1
ORDER BY 4;


-- Bonus: Which is the most rented film?
SELECT
	b.film_id, c.title, COUNT(*) as number_of_rentals
FROM
	rental a
LEFT JOIN
	inventory b ON a.inventory_id = b.inventory_id
LEFT JOIN
	film c ON b.film_id = c.film_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1;

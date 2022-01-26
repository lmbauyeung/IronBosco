USE sakila;

-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT 
	COUNT(*) AS copies_of_hunchback_impossible
FROM
	inventory 
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');


-- 2. List all films whose length is longer than the average of all the films.
SELECT
	title, length
FROM
	film
WHERE length > (SELECT AVG(length) FROM film);


-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT
	first_name, last_name
FROM
	actor
WHERE
	actor_id IN (SELECT actor_id FROM film_actor WHERE film_id =
					(SELECT film_id FROM film where title = 'Alone Trip'));


-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT
	title
FROM
	film
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = 
					(SELECT category_id FROM category WHERE name = 'Family'));


-- 5. Get name and email from customers from Canada using subqueries. 
SELECT
	first_name, last_name, email
FROM
	customer
WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN
						(SELECT city_id FROM city WHERE country_id = 
							(SELECT country_id FROM country WHERE country = 'Canada')));


-- 5. (cont'd) Do the same with joins.
 SELECT
	first_name, last_name, email
FROM
	country a
LEFT JOIN
	city b ON a.country_id = b.country_id
LEFT JOIN
	address c ON b.city_id = c.city_id
LEFT JOIN
	customer d ON c.address_id = d.address_id
WHERE country = 'Canada' AND last_name <> '';


-- 6. Which are films starred by the most prolific actor?
SELECT
	title
FROM
	film
WHERE 
	film_id IN
		(SELECT film_id FROM film_actor WHERE actor_id =
			(SELECT actor_id FROM
				(SELECT actor_id, COUNT(*)
				FROM film_actor
				GROUP BY 1
				ORDER BY 2 DESC
				LIMIT 1) a));


-- 7. Films rented by most profitable customer.
SELECT
	title
FROM
	film
WHERE
	film_id IN
		(SELECT DISTINCT film_id FROM inventory WHERE inventory_id IN 
			(SELECT inventory_id FROM rental WHERE customer_id =
				(SELECT customer_id FROM
					(SELECT customer_id, SUM(amount) AS total_paid_amount FROM payment
					GROUP BY 1
					ORDER BY 2 DESC
					LIMIT 1) a)))
ORDER BY 1;


-- 8. Customers who spent more than the average payments.
SELECT 
	first_name, last_name
FROM
	customer
WHERE
	customer_id IN
	(SELECT customer_id FROM
		(SELECT customer_id, SUM(amount) AS total_amount_per_customer 
        FROM payment
		GROUP BY 1
		HAVING total_amount_per_customer >
			(SELECT SUM(amount)/COUNT(DISTINCT customer_id) FROM payment)) b);


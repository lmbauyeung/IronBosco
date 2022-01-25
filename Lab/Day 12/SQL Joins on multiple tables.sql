USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT
	a.store_id, c.city, d.country
FROM
	store a
LEFT JOIN
	address b ON a.address_id = b.address_id
LEFT JOIN
	city c ON b.city_id = c.city_id
LEFT JOIN
	country d ON c.country_id = d.country_id;
    
    
-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT
	a.store_id, SUM(c.amount) AS revenue
FROM
	store a
LEFT JOIN
	customer b ON a.store_id = b.store_id
LEFT JOIN
	payment c ON b.customer_id = c.customer_id
GROUP BY 1;
    
    
-- 3. What is the average running time(length) of films by category?
SELECT
	a.name, ROUND(AVG(length),1) AS average_duration
FROM
	category a
LEFT JOIN
	film_category b ON a.category_id = b.category_id
LEFT JOIN
	film c ON b.film_id = c.film_id
GROUP BY a.category_id;


-- 4. Which film categories are longest(length)? (Hint: You can rely on question 3 output.)
SELECT
	a.name, ROUND(AVG(length),1) AS average_duration
FROM
	category a
LEFT JOIN
	film_category b ON a.category_id = b.category_id
LEFT JOIN
	film c ON b.film_id = c.film_id
GROUP BY a.category_id
ORDER BY 2 DESC
LIMIT 5;


-- 5. Display the most frequently(number of times) rented movies in descending order.
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
LIMIT 5;


-- 6. List the top five genres in gross revenue in descending order.
SELECT
	f.name, SUM(a.amount) AS gross_revenue
FROM
	payment a
LEFT JOIN
	rental b ON a.rental_id = b.rental_id
LEFT JOIN
	inventory c ON b.inventory_id = c.inventory_id
LEFT JOIN
	film d ON c.film_id = d.film_id
LEFT JOIN
	film_category e ON d.film_id = e.film_id
LEFT JOIN
	category f ON e.category_id = f.category_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT
	*
FROM
	store a
LEFT JOIN
	inventory b ON a.store_id = b.store_id
LEFT JOIN
	film c ON b.film_id = c.film_id
WHERE a.store_id = 1 AND c.title = 'Academy Dinosaur';


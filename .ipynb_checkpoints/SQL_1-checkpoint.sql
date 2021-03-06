USE sakila;
#1A
SELECT first_name, last_name FROM actor;
#1b
SELECT CONCAT( first_name,",",last_name) as Actor_Name FROM actor;
#2A
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";
#2b
SELECT first_name, last_name FROM actor
WHERE last_name like "%GEN%";
#2c
SELECT last_name, first_name FROM actor
WHERE last_name like "%LI%";
#2D
SELECT country_id, country FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");
#3A
ALTER TABLE actor add column description BLOB;
#3B
ALTER TABLE actor DROP COLUMN description;
#4a
USE sakila;
SELECT last_name, Count(last_name) FROM actor
GROUP BY last_name;
#4b
SELECT last_name, Count(last_name) FROM actor
GROUP BY last_name HAVING Count(last_name) >2;
#4c
UPDATE actor
SET first_name = "HARPO" 
WHERE first_name = "GROUCHO";
#4d
UPDATE actor
SET first_name = "GROUCHO" 
WHERE first_name = "HARPO";
#5a
CREATE SCHEMA address;
#6a
SELECT staff.first_name, staff.last_name, address.address
FROM address
JOIN staff
ON staff.address_id = address.address_id;
#6 b
SELECT staff.first_name, staff.last_name, SUM(payment.amount)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE payment.payment_date like "%2005-08%"
GROUP BY staff.staff_id;
#6c
SELECT film.title, COUNT(film_actor.actor_id)
FROM film
JOIN film_actor on film.film_id = film_actor.film_id
GROUP BY film.title;
#6d
SELECT title, Count(title) FROM film
where title = "Hunchback Impossible"
GROUP BY title;
#6e
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS "Total Payment"
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name;
#7a

SELECT title 
FROM film
WHERE title like "Q%" OR title like "K%" and language_id IN
(
SELECT language_id 
FROM language
WHERE name = "English");
#7b

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
SELECT actor_id
FROM film
WHERE title = "Alone Trip");
#7c
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON address.address_id = customer.address_id
JOIN city ON city.city_id = city.city_id 
JOIN country ON country.country_id = city.country_id
WHERE country.country = "Canada";
#7d.
SELECT title, c.name
FROM film f
INNER JOIN film_category fc
ON (f.film_id = fc.film_id)
INNER JOIN category c
ON (c.category_id = fc.category_id)
WHERE c.name = "Family";

SELECT f.title, c.name
FROM film f
INNER JOIN film_category fc
ON (f.film_id = fc.film_id)
INNER JOIN category c
ON (c.category_id = fc.category_id)
WHERE c.name = "Family";
#7e
USE sakila;
SELECT COUNT( rental.rental_date ) AS "Frequenly Rent", film.title 
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY "Frequenly Rent" DESC;  
#7f
SELECT store.store_id, SUM( payment.amount )
FROM store 
JOIN customer ON customer.store_id = store.store_id
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;
#7g
SELECT store.store_id, country.country, city.city
FROM store
JOIN customer ON store.store_id = customer.store_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON country.country_id = city.country_id;
 
 #7h and 8a
CREATE VIEW top_five_genres AS
SELECT SUM(amount) AS ‘Total_Sales’, c.name AS ‘Genre’
FROM payment p
INNER JOIN rental r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory i
ON (r.inventory_id = i.inventory_id)
INNER JOIN film_category fc
ON (i.film_id = fc.film_id)
INNER JOIN category c
ON (fc.category_id = c.category_id)
GROUP BY c.name
ORDER BY SUM(amount) DESC LIMIT 5;
#8 A see above
#8b
SELECT *
FROM top_five_genres;
#8c
DROP VIEW top_five_genres;

USE sakila;
SELECT first_name, last_name FROM sakila.actor;
SELECT concat(first_name,' ',last_name) ActorName from sakila.actor;

SELECT actor_id, last_name FROM sakila.actor WHERE first_name='JOE';
    
SELECT * from sakila.actor WHERE last_name like '%GEN%';

SELECT * from sakila.actor WHERE last_name like '%LI%'
ORDER by last_name, first_name;

SELECT * from country;
SELECT * from country WHERE country in ('Afghanistan', 'Bangladesh', 'China');

ALTER table actor
ADD COLUMN description blob;
SELECT * from actor;

ALTER table actor
DROP COLUMN description;

SELECT last_name, 
count(*) from actor GROUP BY last_name 
ORDER BY count(*) desc;

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*)>1 
ORDER BY COUNT(*) desc;

UPDATE actor
SET first_name='HARPO' WHERE first_name='GROUCHO' and last_name='WILLIAMS';

UPDATE actor
SET first_name='GROUCHO' WHERE first_name='HARPO' and last_name='WILLIAMS';

SHOW CREATE TABLE address;

select * from staff;
select * from address;
select first_name,Last_name,address from staff s join address a on s.address_id=a.address_id;

SELECT sum(amount) FROM payment WHERE staff_id IN(1,2) and month(payment_date)=8 
GROUP BY staff_id;

SELECT * FROM film;
SELECT * FROM film_actor WHERE film_id=1;
SELECT title, count(actor_id) FROM film f JOIN film_actor a on f.film_id=a.film_id
GROUP BY title;

SELECT * FROM film WHERE title='Hunchback Impossible';
SELECT count(title) FROM inventory i join film f ON i.film_id WHERE title='Hunchback Impossible';

SELECT * FROM payment;
SELECT * FROM customer;
SELECT first_name, last_name, sum(amount) as 'Total Payment' FROM payment p
JOIN customer c on p.customer_id=c.customer_id
GROUP BY p.customer_id order by last_name;

SELECT * FROM film
WHERE (title like 'K%' or title like 'Q%') 
AND language_id= (SELECT language_id from language where name='English');

SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT first_name,last_name FROM actor
 WHERE actor_id IN (SELECT actor_id FROM film_actor
 WHERE film_id=(SELECT film_id FROM film WHERE title='Alone Trip'));
 
SELECT * FROM customers;
SELECT * FROM address;
SELECT * FROM city;
SELECT a.name,c.email FROM customer_list a JOIN customer c ON a.ID=c.customer_id WHERE country='Canada';

SELECT * FROM film_list WHERE category='Family';

SELECT * FROM payment ORDER BY customer_id desc;

select f.film_id,title,r.inventory_id,count(customer_id) as "Times rented out" from rental r join inventory i 
on r.inventory_id=i.inventory_id 
join film f on i.film_id=f. film_id
group by title
order by count(customer_id) desc;


SELECT staff_id,sum(amount) FROM payment GROUP BY staff_id;

SELECT s.store_id,c.city,cc.country FROM store s JOIN address a ON s.address_id=a.address_id
JOIN city c ON a.city_id=c.city_id JOIN country cc ON c.country_id=cc.country_id;

SELECT c.name as Generes, SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON c.category_id=fc.category_id
JOIN inventory i ON fc.film_id=i.film_id
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross desc  LIMIT 5;

create VIEW Top_5_category AS

SELECT c.name as Generes, SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON c.category_id=fc.category_id
JOIN inventory i ON fc.film_id=i.film_id
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross desc  LIMIT 5;

SELECT * FROM top_5_category;

DROP VIEW top_5_category;
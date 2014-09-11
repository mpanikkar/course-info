-- Queries on PVFC database:

-- show all data in the customers table
SELECT * FROM customer
LIMIT 5

-- show all data in the products table
SELECT * FROM product
-- show all data in the employees table
SELECT * FROM employee

-- SELECT
-- show me the name, city and state for all customers
SELECT customer_name, customer_city, customer_state
FROM customer


-- ALIAS
-- show me the name, city and state for all customers
SELECT  customer_name AS nom, 
	customer_city AS ville, 
	customer_state AS etat
FROM customer


-- ORDER BY
-- sort that result by state, then customer name
SELECT  customer_name AS nom, 
	customer_city AS ville, 
	customer_state AS etat
FROM customer
ORDER BY customer_state, customer_name

-- show me the names and phone numbers of all our salespeople
SELECT salesperson_name, salesperson_phone
FROM salesperson

-- WHERE
-- show me the name and phone number of the salesperson who covers the 'SouthWest' territory
SELECT salesperson_name, salesperson_phone
FROM salesperson
WHERE territory_id = 2
-- do this with a join
SELECT salesperson_name, salesperson_phone
FROM salesperson S, territory T
WHERE S.territory_id = T.territory_id
AND territory_name = 'SouthWest'
-- another way
SELECT salesperson_name, salesperson_phone
FROM salesperson S 
JOIN territory T ON S.territory_id = T.territory_id
WHERE territory_name = 'SouthWest'

-- WHERE
-- show me the names of all employees who do not have a supervisor
SELECT *
FROM employee
WHERE employee_supervisor = ''

-- DISTINCT
-- show me what kinds of finishes our products come in
SELECT DISTINCT product_finish FROM product
-- show me what states our customers come from
SELECT DISTINCT customer_state FROM customer

-- MIN
-- show me the name and price of our least expensive product
SELECT product_description, product_std_price
FROM product
WHERE product_std_price = 
   (SELECT MIN(product_std_price) FROM product)


-- TOP 3, ORDER BY
-- show me the name, price, and finish of our three most expensive products 
SELECT product_description, product_std_price, product_finish
FROM product
ORDER BY 2 DESC
LIMIT 3


-- MATH
-- let's say we offer a 5% discount on products if you order more than ten of them.  give me the names of our products and the cost to purchase 15 units.  call it 'cost_of_15'.
SELECT 	product_description, 
	product_std_price, 
	((product_std_price*15)*0.95) AS cost_of_15
FROM product


-- DATE MATH
-- show me the number and date for each order, as well as how long ago the order was placed, in days.  call this 'order_age'
SELECT 	order_date, 
	DATE_PART('day', now() - order_date) AS order_age
FROM orders
-- show me the names of our employees and how long in years they have worked for us. call this 'tenure'



-- LIKE, AND, OR
-- what "saw" skills might employees have?
-- list all the customers with the word 'furnishings' in their names
-- list all the products which are desks or tables, with their finishes 
-- list all the products which are not desks or tables, with their prices

-- IN
-- list all customers in New York, New Jersey, Pennsylvania, or Florida

-- COUNT
-- how many customers are in the database?
-- how many customers are in each state?

-- SUM
-- what's the total quantity ordered for each product_id (check the order_line table)

-- BETWEEN
-- what products are priced between 300 and 400 dollars?















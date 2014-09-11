
-- Database for Pine Valley Furniture Company
-- based on textbook publisher's database,
-- converted to PostgreSQL by Joseph Clark.

-- This script implements the data model depicted in figure 2-21, page 79,
-- of "Essentials of Database Management" by Hoffer, Topi, and Ramesh. (2014)







-- There's no CREATE DATABASE command here, so you have to create a database 
-- on your own, then run this script within that database.







-- Drop all tables (if they already exist).
-- This is so we can run the script repeatedly if needed.
-- The CASCADE keyword will delete any foreign keys, views, or
--  other objects that include the table, which would otherwise
--  prevent deletion.

DROP TABLE IF EXISTS uses CASCADE;
DROP TABLE IF EXISTS works_in CASCADE;
DROP TABLE IF EXISTS work_center CASCADE;
DROP TABLE IF EXISTS does_business_in CASCADE;
DROP TABLE IF EXISTS employee_skills CASCADE;
DROP TABLE IF EXISTS supplies CASCADE;
DROP TABLE IF EXISTS produced_in CASCADE;
DROP TABLE IF EXISTS order_line CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS product_line CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS salesperson CASCADE;
DROP TABLE IF EXISTS vendor CASCADE;
DROP TABLE IF EXISTS skill CASCADE;
DROP TABLE IF EXISTS raw_material CASCADE;
DROP TABLE IF EXISTS territory CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS customer CASCADE;






-- Create tables.
-- A key part of converting the database to PostgreSQL was making
--  all table and attribute names lowercase.  
-- Remember this when trying to use the queries in the book!


CREATE TABLE customer (
	customer_id				serial			NOT NULL	PRIMARY KEY,
	customer_name			varchar(25)     NOT NULL,
	customer_address		varchar(30),
	customer_city			varchar(20),
	customer_state			char(2),
	customer_zipcode 		varchar(10)
);


CREATE TABLE territory (
	territory_id			serial			NOT NULL	PRIMARY KEY,
    territory_name			varchar(50)
);


CREATE TABLE does_business_in (
	customer_id				int		NOT NULL	REFERENCES customer(customer_id),
	territory_id			int		NOT NULL	REFERENCES territory(territory_id),
	PRIMARY KEY (customer_id, territory_id)
);


CREATE TABLE salesperson (
	salesperson_id			serial			NOT NULL	PRIMARY KEY,
	salesperson_name		varchar(25),
	salesperson_phone		varchar(50),
	salesperson_fax			varchar(50),
	territory_id			int				NOT NULL	REFERENCES territory(territory_id)
);



CREATE TABLE product_line (
	product_line_id			serial			NOT NULL	PRIMARY KEY,
	product_line_name		varchar(50)
);


CREATE TABLE product (
	product_id				serial			NOT NULL	PRIMARY KEY,
	product_line_id			int				NOT NULL	REFERENCES product_line(product_line_id),
	product_description		varchar(50),
	product_finish			varchar(20),
	product_std_price 		money
);


CREATE TABLE work_center (
	work_center_id			varchar(12)		NOT NULL	PRIMARY KEY,
	work_center_location	varchar(30)
);


CREATE TABLE produced_in (
	product_id				int				NOT NULL	REFERENCES product(product_id),
	work_center_id			varchar(12)		NOT NULL	REFERENCES work_center(work_center_id),
	PRIMARY KEY (product_id, work_center_id)
);



CREATE TABLE orders (
	order_id				serial			NOT NULL	PRIMARY KEY,
	customer_id				int				NOT NULL	REFERENCES customer(customer_id),
	order_date				date			DEFAULT now()
);


CREATE TABLE order_line (
	order_id				serial			NOT NULL	REFERENCES orders(order_id),
	product_id				int				NOT NULL	REFERENCES product(product_id),
	ordered_quantity		smallint,
	PRIMARY KEY (order_id, product_id)
);



-- note that employee_supervisor is not defined as a recursive foreign key; 
-- that was a decision made by the textbook authors and I left it alone.

CREATE TABLE employee (
	employee_id				char(10)    	NOT NULL	PRIMARY KEY,
	employee_name			varchar(25),
	employee_address		varchar(30),
	employee_birthdate		date,
	employee_city			varchar(20),
	employee_state			char(2),
	employee_zipcode		varchar(10),
	employee_date_hired		date,
	employee_supervisor  	char(10)
);


CREATE TABLE skill (
	skill_id				varchar(12)		NOT NULL	PRIMARY KEY,
	skill_description		varchar(30)
);


CREATE TABLE employee_skills (
	employee_id				char(10)		NOT NULL	REFERENCES employee(employee_id),
	skill_id				varchar(12)		NOT NULL	REFERENCES skill(skill_id),
	PRIMARY KEY (employee_id, skill_id)
);


CREATE TABLE works_in (
	employee_id				char(10)		NOT NULL	REFERENCES employee(employee_id),
	work_center_id			varchar(12)		NOT NULL	REFERENCES work_center(work_center_id),
	PRIMARY KEY (employee_id, work_center_id)
);



CREATE TABLE vendor (
	vendor_id				serial			NOT NULL	PRIMARY KEY,
	vendor_name				varchar(25),
	vendor_address			varchar(30),
	vendor_city				varchar(20),
	vendor_state			char(2),
	vendor_zipcode			varchar(50),
	vendor_fax				varchar(10),
	vendor_phone			varchar(10),
	vendor_contact			varchar(50),
	vendor_tax_id			varchar(50)
);


CREATE TABLE raw_material (
	material_id				serial			NOT NULL	PRIMARY KEY,
	material_name			varchar(30),
	material_std_cost		money,
	unit_of_measure			varchar(10)
);


CREATE TABLE supplies (
	vendor_id				int				NOT NULL	REFERENCES vendor(vendor_id),
	material_id				int				NOT NULL	REFERENCES raw_material(material_id),
	supplies_unit_price		money,
	PRIMARY KEY (vendor_id, material_id)
);


CREATE TABLE uses (
	product_id				int				NOT NULL	REFERENCES product(product_id),
	material_id				int				NOT NULL	REFERENCES raw_material(material_id),
	goes_into_quantity		int,
	PRIMARY KEY (product_id, material_id)
);










-- The new tables should be empty, but we'll run this code to delete all data just in case.

DELETE FROM uses;
DELETE FROM works_in;
DELETE FROM work_center;
DELETE FROM does_business_in;
DELETE FROM employee_skills;
DELETE FROM supplies;
DELETE FROM produced_in;
DELETE FROM order_line;
DELETE FROM product;
DELETE FROM product_line;
DELETE FROM orders;
DELETE FROM salesperson;
DELETE FROM vendor;
DELETE FROM skill;
DELETE FROM raw_material;
DELETE FROM territory;
DELETE FROM employee;
DELETE FROM customer;




-- Now, we insert some sample data so that we can run queries.



INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (1, 'Contemporary Casuals', '1355 S Hines Blvd', 'Gainesville', 'FL', '32601-2871');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (2, 'Value Furniture', '15145 S.W. 17th St.', 'Plano', 'TX', '75094-7743');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (3, 'Home Furnishings', '1900 Allard Ave.', 'Albany', 'NY', '12209-1125');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (4, 'Eastern Furniture', '1925 Beltline Rd.', 'Carteret', 'NJ', '07008-3188');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (5, 'Impressions', '5585 Westcott Ct.', 'Sacramento', 'CA', '94206-4056');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (6, 'Furniture Gallery', '325 Flatiron Dr.', 'Boulder', 'CO', '80514-4432');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (7, 'Period Furniture', '394 Rainbow Dr.', 'Seattle', 'WA', '97954-5589');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (8, 'California Classics', '816 Peach Rd.', 'Santa Clara', 'CA', '96915-7754');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (9, 'M and H Casual Furniture', '3709 First Street', 'Clearwater', 'FL', '34620-2314');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (10, 'Seminole Interiors', '2400 Rocky Point Dr.', 'Seminole', 'FL', '34646-4423');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (11, 'American Euro Lifestyles', '2424 Missouri Ave N.', 'Prospect Park', 'NJ', '07508-5621');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (12, 'Battle Creek Furniture', '345 Capitol Ave. SW', 'Battle Creek', 'MI', '49015-3401');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (13, 'Heritage Furnishings', '66789 College Ave.', 'Carlisle', 'PA', '17013-8834');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (14, 'Kaneohe Homes', '112 Kiowai St.', 'Kaneohe', 'HI', '96744-2537');
INSERT INTO customer  (customer_id, customer_name, customer_address, customer_city, customer_state, customer_zipcode)
	VALUES  (15, 'Mountain Scenes', '4132 Main Street', 'Ogden', 'UT', '84403-4432');



INSERT INTO territory  (territory_id, territory_name) VALUES  (1, 'SouthEast');
INSERT INTO territory  (territory_id, territory_name) VALUES  (2, 'SouthWest');
INSERT INTO territory  (territory_id, territory_name) VALUES  (3, 'NorthEast');
INSERT INTO territory  (territory_id, territory_name) VALUES  (4, 'NorthWest');
INSERT INTO territory  (territory_id, territory_name) VALUES  (5, 'Central');



INSERT INTO does_business_in  (customer_id, territory_id) VALUES  (1, 1);
INSERT INTO does_business_in  (customer_id, territory_id) VALUES  (1, 2);
INSERT INTO does_business_in  (customer_id, territory_id) VALUES  (2, 2);
INSERT INTO does_business_in  (customer_id, territory_id) VALUES  (3, 3);
INSERT INTO does_business_in  (customer_id, territory_id) VALUES  (4, 3);
INSERT INTO does_business_in  (customer_id, territory_id) VALUES  (5, 2);
INSERT INTO does_business_in  (customer_id, territory_id) VALUES  (6, 5);



INSERT INTO employee  (employee_id, employee_name, employee_address, employee_city, employee_state, employee_zipcode, employee_date_hired, employee_birthdate, employee_supervisor)
	VALUES  ('123-44-345', 'Jim Jason', '2134 Hilltop Rd', '', 'TN', '', '12-Jun-2005', '29-Feb-1980', '454-56-768');
INSERT INTO employee  (employee_id, employee_name, employee_address, employee_city, employee_state, employee_zipcode, employee_date_hired, employee_birthdate, employee_supervisor)
	VALUES  ('454-56-768', 'Robert Lewis', '17834 Deerfield Ln', 'Nashville', 'TN', '', '01-Jan-1999', '8-Aug-1972', '');



INSERT INTO skill  (skill_id, skill_description) VALUES  ('BS12', '12in Band Saw');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('QC1', 'Quality Control');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('RT1', 'Router');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('SO1', 'Sander-Orbital');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('SB1', 'Sander-Belt');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('TS10', '10in Table Saw');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('TS12', '12in Table Saw');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('UC1', 'Upholstery Cutter');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('US1', 'Upholstery Sewer');
INSERT INTO skill  (skill_id, skill_description) VALUES  ('UT1', 'Upholstery Tacker');



INSERT INTO employee_skills  (employee_id, skill_id) VALUES  ('123-44-345', 'BS12');
INSERT INTO employee_skills  (employee_id, skill_id) VALUES  ('123-44-345', 'RT1');
INSERT INTO employee_skills  (employee_id, skill_id) VALUES  ('454-56-768', 'BS12');



INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1001, '21-Oct-2013', 1);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1002, '21-Oct-2013', 8);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1003, '22-Oct-2013', 15);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1004, '22-Oct-2013', 5);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1005, '24-Oct-2013', 3);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1006, '24-Oct-2013', 2);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1007, '27-Oct-2013', 11);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1008, '30-Oct-2013', 12);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1009, '05-Nov-2013', 4);
INSERT INTO orders (order_id, order_date, customer_id) VALUES  (1010, '05-Nov-2013', 1);



INSERT INTO product_line  (product_line_id, product_line_name) VALUES  (1, 'Cherry Tree');
INSERT INTO product_line  (product_line_id, product_line_name) VALUES  (2, 'Scandinavia');
INSERT INTO product_line  (product_line_id, product_line_name) VALUES  (3, 'Country Look');



INSERT INTO product (product_id, product_description, product_finish, product_std_price, product_line_id)
	VALUES  (1, 'End Table', 'Cherry', 175, 1);
INSERT INTO product (product_id, product_description, product_finish, product_std_price, product_line_id)
	VALUES  (2, 'Coffee Table', 'Natural Ash', 200, 2);
INSERT INTO product (product_id, product_description, product_finish, product_std_price, product_line_id)
	VALUES  (3, 'Computer Desk', 'Natural Ash', 375, 2);
INSERT INTO product (product_id, product_description, product_finish, product_std_price, product_line_id)
	VALUES  (4, 'Entertainment Center', 'Natural Maple', 650, 3);
INSERT INTO product (product_id, product_description, product_finish, product_std_price, product_line_id)
	VALUES  (5, 'Writers Desk', 'Cherry', 325, 1);
INSERT INTO product (product_id, product_description, product_finish, product_std_price, product_line_id)
	VALUES  (6, '8-Drawer Desk', 'White Ash', 750, 2);
INSERT INTO product (product_id, product_description, product_finish, product_std_price, product_line_id)
	VALUES  (7, 'Dining Table', 'Natural Ash', 800, 2);
INSERT INTO product (product_id, product_description, product_finish, product_std_price, product_line_id)
	VALUES  (8, 'Computer Desk', 'Walnut', 250, 3);



INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1001, 1, 2);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1001, 2, 2);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1001, 4, 1);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1002, 3, 5);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1003, 3, 3);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1004, 6, 2);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1004, 8, 2);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1005, 4, 3);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1006, 4, 1);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1006, 5, 2);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1006, 7, 2);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1007, 1, 3);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1007, 2, 2);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1008, 3, 3);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1008, 8, 3);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1009, 4, 2);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1009, 7, 3);
INSERT INTO order_line (order_id, product_id, ordered_quantity) VALUES  (1010, 8, 10);



INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_phone, salesperson_fax, territory_id) VALUES  (1, 'Doug Henny', '8134445555', '', 1);
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_phone, salesperson_fax, territory_id) VALUES  (2, 'Robert Lewis', '8139264006', '', 2);
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_phone, salesperson_fax, territory_id) VALUES  (3, 'William Strong', '5053821212', '', 3);
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_phone, salesperson_fax, territory_id) VALUES  (4, 'Julie Dawson', '4355346677', '', 4);
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_phone, salesperson_fax, territory_id) VALUES  (5, 'Jacob Winslow', '2238973498', '', 5);



INSERT INTO work_center  (work_center_id, work_center_location) VALUES ('SM1', 'Main Saw Mill');
INSERT INTO work_center  (work_center_id, work_center_location) VALUES ('WR1', 'Warehouse and Receiving');



INSERT INTO works_in (employee_id, work_center_id) VALUES ('123-44-345', 'SM1');





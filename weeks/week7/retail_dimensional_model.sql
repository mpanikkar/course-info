
-- Dimensional Database schema for the Retail case for PostgreSQL
-- based roughly on ch. 3 of Kimball & Ross's "The Data Warehouse Toolkit" (3rd ed.)



-- There's no CREATE DATABASE command here, so you have to create a database 
-- on your own, then run this script within that database.




-- Drop all tables (if they already exist).
-- This is so we can run the script repeatedly if needed.
-- The CASCADE keyword will delete any foreign keys, views, or
--  other objects that include the table, which would otherwise
--  prevent deletion.

DROP TABLE IF EXISTS retail_fact CASCADE;
DROP TABLE IF EXISTS date_dim CASCADE;
DROP TABLE IF EXISTS product_dim CASCADE;
DROP TABLE IF EXISTS store_dim CASCADE;







-- Create dimension tables.
-- Naming convention: 
--   dimensions: <dimension name>_dim
--   facts: <fact name>_fact




-- date is much like the example but we don't have a "fiscal" calendar so it's shorter
CREATE TABLE date_dim (
    date_key                        serial      NOT NULL    PRIMARY KEY,
    date                            date,
    day_number_in_week              smallint,   -- sunday = 0, saturday = 6
    day_number_in_calendar_month    smallint,
    day_number_in_calendar_year     smallint,
    calendar_week_number_in_year    smallint,
    calendar_month_number_in_year   smallint,
    calendar_quarter                char(1),
    calendar_year                   smallint,
    day_of_week                     char(9),
    calendar_month_name             char(9),
    full_date_description           char(20),
    calendar_year_month             char(7),    -- label of form YYYY-MM
    calendar_year_quarter           char(6)    -- label of form YYYY-Q
);

-- product dimension somewhat simpler than the book's version
CREATE TABLE product_dim (
    product_key                     serial      NOT NULL    PRIMARY KEY,
    sku                             char(10),   -- a "natural key" from source system
    product_description             char(35),
    department_description          char(25),
    brand_description               char(25),
    category_description            char(25),
    subcategory_description         char(25)
);

-- store dimension
CREATE TABLE store_dim (
    store_key                       serial      NOT NULL    PRIMARY KEY,
    store_number                    smallint,   -- a "natural key" from source system
    store_name                      char(30),
    store_street_address            char(30),
    store_city                      char(20),
    store_county                    char(20),
    store_state                     char(2),    -- or province
    store_zipcode                   char(6),    -- Canada zipcodes are 6 characters
    store_manager                   char(25),
    store_region                    char(10)
);



-- Create the Retail Sales fact table.
-- Grain is one row per product in a transaction.
CREATE TABLE retail_fact (
    -- foreign keys
    date_key                        integer     references date_dim(date_key),
    product_key                     integer     references product_dim(product_key),
    store_key                       integer     references store_dim(store_key),
    pos_transaction_number          integer,    -- degenerate dimension
    -- here begin facts
    sales_quantity                  smallint,
    regular_unit_price              money,
    discount_unit_amount            money,
    net_unit_price                  money,
    total_sales_dollar_amount       money,
    total_discount_dollar_amount    money,
    -- and the primary key
    PRIMARY KEY (product_key, pos_transaction_number)
);







-- This populates the date dimension:

insert into date_dim (date, day_number_in_week, day_number_in_calendar_month,
                      day_number_in_calendar_year, calendar_week_number_in_year, 
                      calendar_month_number_in_year, calendar_quarter, calendar_year, 
                      day_of_week, calendar_month_name, full_date_description,
                      calendar_year_month, calendar_year_quarter )

	SELECT 
        -- 'extract' and 'to_char' are powerful Postgres functions for manipulating dates
        d as date,
        extract(dow from d) as day_number_in_week,
        extract(day from d) as day_number_in_calendar_month,
        extract(doy from d) as day_number_in_calendar_year,
        extract(week from d) as calendar_week_number_in_year,
        extract(month from d) as calendar_month_number_in_year,
        extract(quarter from d) as calendar_quarter,
        extract(year from d) as calendar_year,
        to_char(d,'Day') as day_of_week,
        to_char(d,'Month') as calendar_month_name,
        to_char(d,'MonthDD, YYYY') as full_date_description,
        to_char(d,'YYYY-MM') as calendar_year_month,
        to_char(d,'YYYY-Q') as calendar_year_quarter
	-- this line creates a temporary table with one column, "d", containing dates
	FROM (select date(generate_series(DATE '20120101', DATE '20141231', interval '1' day)) as d) as daterange

